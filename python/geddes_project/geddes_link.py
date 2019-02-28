"""
Scott Renton, May 2018
Generate dspace import for Geddes
"""
import xml.etree.ElementTree as ET
import os
import shutil
import argparse
import csv
from xml.dom import minidom
from variables_geddes import ALL_VARS
from datetime import date


#read arguments
collection = ''
environment = ''

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--collection',
            action="store", dest="collection",
            help="collection loading", default="spam")
parser.add_argument('-e', '--environment',
            action="store", dest="environment",
            help="environment- test or live", default="spam")
args = parser.parse_args()
print(args)
collection= str(args.collection)
environment =str(args.environment)

if environment == 'live':
    environment = ''

md_file= open(ALL_VARS['MAPFILE'], 'r')
md_mapping = csv.DictReader(md_file, delimiter=':')
md_map_array = list(md_mapping)
md_map_len = len(md_map_array)
md_file.close()

fmp_array = []
fmp_file = open(collection + "/" + environment + ALL_VARS['IMPORTMAPFILEPREV'], 'r')
count = 0
for line in fmp_file:
    fmp_line= line.strip("\n")
    fmp_line = fmp_line.split(" ")
    fmp_array.append(fmp_line)
    count += 0
#fmp_mapping = csv.DictReader(fmp_file, delimiter=" ")
#fmp_array = list(fmp_mapping)
fmp_len = len(fmp_array)

#for line in fmp_file:
 #   fmp_mapping = fmp_file.read().split(' ')




fmp_file.close()

#open writable mapping file (used for update of existing items in dspace import
fm = open(collection + "/" + environment + ALL_VARS['IMPORTMAPFILE'],'w')

#delete all existing import structure
for root, dirs, files in os.walk(collection + "/" + ALL_VARS['EFOLD']):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
for root, dirs, files in os.walk(collection + "/" + ALL_VARS['NFOLD']):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))

def control():
    """
    action- process DC first, and then Edinburgh
    """
    #get urls
    url_list = ALL_VARS['EAD_URL_LIST']
    url_list_len = len(url_list)
    print('LEN'+str(url_list_len))
    url_counter = 0
    child_no = 0
    #for each URL, estanblish metadata format and institution
    while url_counter < url_list_len:
        if 'oai_dc' in url_list[url_counter]:
            md_type = 'dc'
        else:    
            md_type = 'ead'
        if 'ed.ac.uk' in url_list[url_counter]: 
            inst = 'EDI'
        else:
            inst = 'STR'
        rtoken = ''
        times_round = 0

        while times_round == 0 or rtoken != '':
            if rtoken == '':
                url = url_list[url_counter]
                print('getting data for ' +url)
                data = get_data(url)
            else:
                url = url_list[url_counter] + '&resumptionToken=' + rtoken
                data = get_data(url)
            child_no = process_xml(data, child_no, md_type, inst)
            print('Records harvested: ' + str(child_no) + '(URL: ' + url + ')')
            rtoken = get_rtoken(data)
            times_round += 1
        url_counter += 1

    #At the end, we need to check if there is anything that was on the map file
    #for the previous run that is no longer available. This should be reported.
    disappearedarray = []
    m = 0
    while m < fmp_len:
        found = 0
        try:
            found = os.path.isdir(collection  + "/" + ALL_VARS['EFOLD'] + fmp_array[m][0])
        except ValueError:
            print("failure")
        if found == 0:
            disappearedarray.append(str(fmp_array[m][0]))
        m += 1
    vl = open(collection + "/" + environment + "vanished.log", "w")
    for disappeared in disappearedarray:
        print("Record vanished:" + disappeared)
        vl.write(disappeared)
    vl.close()
    fm.close()

    print("finished")


def get_data(url):
    """
    populate variables with oai responses
    """
    import requests
    #request = urllib.request.Request(url)
    #response_file = urllib.request.urlopen(url)
    #data = response_file.read()
    #response_file.close()
    r= requests.get(url)
    data =  r.text
    return data

def get_rtoken(data):
    """
    get the resumption token from the data
    """
    resumption_token = ''
    tree = ET.ElementTree(ET.fromstring(data))
    xmlroot = tree.getroot()
    for child in xmlroot:
        if child.tag == '{http://www.openarchives.org/OAI/2.0/}ListRecords':
            for subchild in child:
                if subchild.tag == '{http://www.openarchives.org/OAI/2.0/}resumptionToken':
                    resumption_token = subchild.text
                    #print(resumption_token)
    return resumption_token

def process_xml(data, child_no, md_type, inst):
    """
    parse oai XML into something usable
    """
    level = ""
    db_id = ""
    #Dublin Core first
    if md_type == 'dc':
        tree = ET.ElementTree(ET.fromstring(data))
        xmlroot = tree.getroot()
        for child in xmlroot:
            if child.tag == '{http://www.openarchives.org/OAI/2.0/}ListRecords':
                for subchild in child:
                    md_array = []
                    for subsubchild in subchild:
                        if subsubchild.tag == '{http://www.openarchives.org/OAI/2.0/}header':
                            for item in subsubchild:
                                if "identifier" in item.tag:
                                    md_array.append({"tag": item.tag,
                                                    "text": item.text})
                        if subsubchild.tag == '{http://www.openarchives.org/OAI/2.0/}metadata':
                            for metadatachild in subsubchild:
                                for item in metadatachild:
                                    md_array.append({"tag": item.tag,
                                                    "text": item.text})
                        if subsubchild.tag == '{http://www.openarchives.org/OAI/2.0/}about':
                            for child in subsubchild:
                                for entry in child:
                                    for item in entry:
                                        if item.tag == "{http://www.w3.org/2005/Atom}link":
                                            md_array.append({"tag": 'imageUri',
                                                    "text": item.attrib['href']})
                    child_no  = write_metadata(child_no, md_array, level, md_type, inst, db_id)
    #Then EAD- this is horrible, but I'm really struggling to modularise it given the nature of passing things in and out!
    #Caveat: we appear to have no subfonds, but if we do, I need to alter this.
    elif md_type == 'ead':
        import re
        data_amend = re.sub(r'<OAI-PMH.*?>', '<OAI-PMH>', str(data))
        #file.write(data_amend)
        parser = ET.XMLParser(encoding="utf-8")
        xmlroot = ET.fromstring(data_amend, parser=parser)
        for child in xmlroot:
            if child.tag == 'GetRecord':
                for subchild in child:
                    for subsubchild in subchild:
                        for eadchild in subsubchild:
                            for levelchild in eadchild:
                                #FONDS
                                if (levelchild.tag  =='{urn:isbn:1-931666-22-9}archdesc'):
                                    for bitchild in levelchild:
                                        for partchild in bitchild:
                                            if (partchild.tag == '{urn:isbn:1-931666-22-9}c'):
                                                #SERIES
                                                level = partchild.get('level')
                                                for didchild in partchild:
                                                    if (didchild.tag == '{urn:isbn:1-931666-22-9}did'):
                                                        md_array = []
                                                        for datachild in didchild:
                                                             md_array.append({"tag": datachild.tag,
                                                                              "text": datachild.text})
                                                             if datachild.tag == '{urn:isbn:1-931666-22-9}unitid':
                                                                 series_parent_id = datachild.text
                                                                 for extptr in datachild:
                                                                     db_id = extptr.attrib['href']
                                                        child_no = write_metadata(child_no, md_array, level, md_type, inst, db_id)
                                                    elif (didchild.tag == '{urn:isbn:1-931666-22-9}c'):
                                                        #SUBSERIES
                                                        level = didchild.get('level')
                                                        for did1child in didchild:
                                                            if (did1child.tag == '{urn:isbn:1-931666-22-9}did'):
                                                                md_array = []
                                                                md_array.append({"tag": "parent",
                                                                                     "text": series_parent_id}) 
                                                                for datachild in did1child:
                                                                    md_array.append({"tag": datachild.tag,
                                                                                     "text": datachild.text})
                                                                    if datachild.tag == '{urn:isbn:1-931666-22-9}unitid':
                                                                        subseries_parent_id = datachild.text
                                                                        for extptr in datachild:
                                                                           db_id = extptr.attrib['href']
                                                                child_no = write_metadata(child_no, md_array, level, md_type, inst, db_id)
                                                            elif(did1child.tag == '{urn:isbn:1-931666-22-9}c'):  
                                                                #ITEM
                                                                level = did1child.get('level')
                                                                for did2child in did1child:
                                                                    if (did2child.tag == '{urn:isbn:1-931666-22-9}did'):
                                                                        md_array = []
                                                                        md_array.append({"tag": "parent",
                                                                                     "text": subseries_parent_id}) 
                                                                        for datachild in did2child:
                                                                            md_array.append({"tag": datachild.tag,
                                                                                             "text": datachild.text})
                                                                            if datachild.tag == '{urn:isbn:1-931666-22-9}unitid':
                                                                                item_parent_id = datachild.text
                                                                                for extptr in datachild:
                                                                                    db_id = extptr.attrib['href']
                                                                            if datachild.tag  == '{urn:isbn:1-931666-22-9}origination':
                                                                                for orig in datachild:
                                                                                    if orig.tag == '{urn:isbn:1-931666-22-9}persname':
                                                                                        md_array.append({"tag":"creator",
                                                                                                         "text":orig.text})
                                                                            if datachild.tag == '{urn:isbn:1-931666-22-9}daogrp':  
                                                                                for dig in datachild:
                                                                                    if dig.tag == '{urn:isbn:1-931666-22-9}daoloc':
                                                                                        image_name = dig.get("{http://www.w3.org/1999/xlink}href")
                                                                                        image_title = dig.get("{http://www.w3.org/1999/xlink}title")
                                                                                        image = image_name + "|" + image_title
                                                                                        md_array.append({"tag":"imageUri",
                                                                                                         "text":image})
                                                                    elif did2child.tag == '{urn:isbn:1-931666-22-9}scopecontent':
                                                                        for scopechild in did2child:
                                                                            if scopechild.tag == '{urn:isbn:1-931666-22-9}p':
                                                                               md_array.append({"tag": scopechild.tag,
                                                                                             "text": scopechild.text})
                                                                child_no = write_metadata(child_no, md_array, level, md_type, inst, db_id) 
                                                                for did2child in did1child:
                                                                    if (did2child.tag == '{urn:isbn:1-931666-22-9}c'): 
                                                                        #PART
                                                                        level = did2child.get('level')
                                                                        for did3child in did2child:
                                                                            if (did3child.tag == '{urn:isbn:1-931666-22-9}did'):
                                                                                md_array = []
                                                                                md_array.append({"tag": "parent",
                                                                                                     "text": item_parent_id}) 
                                                                                for datachild in did3child:
                                                                                    md_array.append({"tag": datachild.tag,
                                                                                                     "text": datachild.text})
                                                                                    if datachild.tag == '{urn:isbn:1-931666-22-9}unitid':
                                                                                        for extptr in datachild:
                                                                                            db_id = extptr.attrib['href']
                                                                                child_no = write_metadata(child_no, md_array, level, md_type, inst, db_id)
                                           
    return child_no

def write_metadata (child_no, md_array, level, md_type, inst, db_id):
    """
    write data to folder
    """
    #Level will go into format
    if level != "":
        md_array.append({"tag":"level", "text":str(level).title()})
    #Institution for publisher and needed for disambiguation of folders too
    if inst != "":    
        md_array.append({"tag":"publisher", "text": inst})
    #Essential for pushing back to original context
    if db_id != "":    
        md_array.append({"tag":"link", "text":"https://test.archives.collections.ed.ac.uk/repositories/2/archival_objects/"+db_id})

    child_no += 1
    folder_no = ""
    import xml.etree.cElementTree as ETOut
    outroot = ETOut.Element(ALL_VARS['DCHEADER'])
    dcvalue = ETOut.SubElement(outroot, "dcvalue")
    dcvalue.set('element', "date")
    dcvalue.set('qualifier', "issued")
    dcvalue.text = str(date.today())
    out_file = ""
    #Parse Metadata
    for item in md_array:
        mdqualifier = ""
        dctag = ""

        if "{" in item["tag"]:
            dctag=item["tag"].split("}")[1]
        else:
            dctag=item["tag"]

        if "identifier" in item["tag"]:
            if "http" in item["text"]:
                dctag = "link"

        if ("identifier" in item["tag"] and "oai" in item["text"]) or "unitid" in item["tag"]:
            #generate folder name so it is unique but usable
            if "identifier" in item["tag"]:
                folder_no = inst + "_" +item["text"].replace("oai:atom.lib.strath.ac.uk:", "")
            elif "unitid" in item["tag"]:
                folder_no = inst + "_" +db_id
            existing = False
            count = 0
            while count < fmp_len:
                if folder_no == fmp_array[count][0]:
                    existing = True
                    fm.write(str(fmp_array[count][0]) + " " + str(fmp_array[count][1]) + "\n")
                count += 1
            if existing:
                subfolder = collection + "/" + ALL_VARS['EFOLD'] + folder_no + "/"
            else:
                subfolder = collection + "/" + ALL_VARS['NFOLD'] + folder_no + "/"
            #create subfolder depending  on whether it is a new or existing record
            os.makedirs(subfolder)
            os.chmod(subfolder, 0o777)
            out_file = subfolder + ALL_VARS['DCFILE']
            contents_file = subfolder + "contents"
            cfile = open(contents_file, "w")
            cfile.close()

        row = 0
        #get dublin core metadata from mapping file
        while row < md_map_len:
            if md_map_array[row]['dctag'] == dctag:
                mdschema = str(md_map_array[row]['dc'] + "value")
                mdelement = str(md_map_array[row]['element'])
                if md_map_array[row]['qualifier'] == 'noqual':
                     mdqualifier = str('')
                else:
                    mdqualifier = str(md_map_array[row]['qualifier'])
                #print(item["tag"] + dctag + mdschema + mdelement + mdqualifier + str(item["text"]))
                dcvalue = ETOut.SubElement(outroot, mdschema)
                dcvalue.set('element', mdelement)
                dcvalue.set('qualifier', mdqualifier)
                dcvalue.text = item["text"]
            row +=1

    #only write metadata if there is a folder to write to
    if folder_no != '':
        rough_string = ETOut.tostring(outroot, 'utf-8')
        reparsed = minidom.parseString(rough_string)
        pretty_string = reparsed.toprettyxml(indent="\t")
        metadata_file = open(out_file, "w")
        metadata_file.write(pretty_string)
        metadata_file.close()
    return child_no
control()
