"""
Scott Renton, May 2018
Generate dspace import for Geddes
"""
import xml.etree.ElementTree as ET
import urllib.request
import os
import shutil
#import difflib
#import csv
from xml.dom import minidom
from variables import ALL_VARS

outfile = 'geddes_output.txt'
file = open(outfile, "w")
        

for root, dirs, files in os.walk(ALL_VARS['EFOLD']):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
for root, dirs, files in os.walk(ALL_VARS['NFOLD']):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
#CSVFILE2 = open(ALL_VARS['MAPFILE'], 'rb')
#MAPPING = csv.DictReader(CSVFILE2, delimiter=':')
#MAPARRAY = list(MAPPING)
#MAPLEN = len(MAPARRAY)
def control():
    """
    action- process Strathclyde first, and then Edinburgh
    """
    dc_url_list = ALL_VARS['DC_URL_LIST']
    slug_list=[]
    dc_counter = 0
    while dc_counter < len(dc_url_list):
        if dc_url_list[dc_counter] != "":
            rtoken = ''
            times_round = 0
            while times_round == 0 or rtoken != '':
                if rtoken == '':
                    dc_url = dc_url_list[dc_counter]
                    data = get_data(dc_url)
                else:
                    dc_url = dc_url_list[dc_counter] + '&resumptionToken=' + rtoken
                    data = get_data(dc_url)
                slug_list = get_slugs(data, slug_list)
                rtoken = get_rtoken(data)
                times_round += 1
                #print '\n'.join(difflib.ndiff([strath_rtoken], [old_strath_rtoken]))
        dc_counter += 1
    url_list = ALL_VARS['EAD_URL_LIST']
    url_list_len = len(url_list)
    url_counter = 0
    child_no = 0
    while url_counter < url_list_len:
        if 'oai_dc' in url_list[url_counter]:
            md_type = 'dc'
        else:    
            md_type = 'ead'
        if 'ed.ac.uk' in url_list[url_counter]: 
            inst = 'University of Edinburgh'
        else:
            inst = 'University of Strathclyde'
        rtoken = ''
        times_round = 0
        while times_round == 0 or rtoken != '':
            if rtoken == '':
                url = url_list[url_counter]
                data = get_data(url)
            else:
                url = url_list[url_counter] + '&resumptionToken=' + rtoken
                data = get_data(url)
            child_no = process_xml(data, child_no, md_type, inst)
            print('Records harvested: ' + str(child_no) + '(URL: ' + url + ')')
            rtoken = get_rtoken(data)
            times_round += 1
            #print '\n'.join(difflib.ndiff([strath_rtoken], [old_strath_rtoken]))
        url_counter += 1
    print("finished")
    
def get_slugs(data, slug_list):
    """
    Get slugs for reference 
    """
    tree = ET.ElementTree(ET.fromstring(data))
    xmlroot = tree.getroot()
   # headidentifier = ''
    for child in xmlroot:
        if child.tag == '{http://www.openarchives.org/OAI/2.0/}ListRecords':
            for subchild in child:
                for subsubchild in subchild:
                    #if subsubchild.tag == '{http://www.openarchives.org/OAI/2.0/}header':
                        #for child in subsubchild:
                         #   if child.tag == '{http://www.openarchives.org/OAI/2.0/}identifier':
                          #      headidentifier = child.text
                    if subsubchild.tag == '{http://www.openarchives.org/OAI/2.0/}metadata':
                        for metadatachild in subsubchild:
                            slug = ''
                            strath_id = ''
                            for item in metadatachild:
                                if item.tag == '{http://purl.org/dc/elements/1.1/}identifier':
                                    if 'ica-atom' in item.text:
                                        slug = item.text
                                    else:
                                        strath_id = item.text
                            slug_list.append({"id": strath_id, "slug": slug })

    return slug_list
    

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
    if md_type == 'dc':
        tree = ET.ElementTree(ET.fromstring(data))
        xmlroot = tree.getroot()
        for child in xmlroot:
            if child.tag == '{http://www.openarchives.org/OAI/2.0/}ListRecords':
                for subchild in child:
                    md_array = []
                    for subsubchild in subchild:
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
                                            md_array.append({"tag": 'imageURI',
                                                    "text": item.attrib['href']})
                    child_no  = write_metadata(child_no, md_array, level, md_type, inst, db_id)
     
    elif md_type == 'ead':
        import re
        data_amend = re.sub(r'<OAI-PMH.*?>', '<OAI-PMH>', str(data))
        file.write(data_amend)
        parser = ET.XMLParser(encoding="utf-8")
        xmlroot = ET.fromstring(data_amend, parser=parser)
        for child in xmlroot:
            if child.tag == 'GetRecord':
                for subchild in child:
                    for subsubchild in subchild:
                        for eadchild in subsubchild:
                            for levelchild in eadchild:
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
                                                                                        md_array.append({"tag":"imageURI",
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
    if level != "":
        md_array.append({"tag":"format", "text":str(level).title()})
    if inst != "":    
        md_array.append({"tag":"publisher", "text": inst})
    if db_id != "":    
        md_array.append({"tag":"link", "text":"https://test.archives.collections.ed.ac.uk/repositories/2/archival_objects/"+db_id})
 
    folder_no = str(child_no).zfill(5)
    child_no += 1
    import xml.etree.cElementTree as ETOut
    outroot = ETOut.Element(ALL_VARS['DCHEADER'])
    map_line = 0
    existing = False
    map_file = open("testmapfile.txt")
    for line in map_file.readlines():
        file_folder_no = line.split(' ')[0]
        if folder_no == file_folder_no:
            existing = True
        map_line += 1
    if existing:
        subfolder = ALL_VARS['EFOLD'] + folder_no + "/"
    else:
        subfolder = ALL_VARS['NFOLD'] + folder_no + "/"
    os.makedirs(subfolder)
    os.chmod(subfolder, 0o777)
    out_file = subfolder + ALL_VARS['DCFILE']
    contents_file = subfolder + "contents"
    cfile = open(contents_file, "w")
    cfile.close()
    for item in md_array:
        mdqualifier = ""
        dctag = ""
        if "{" in item["tag"]:
            dctag=item["tag"].split("}")[1]
        else:
            dctag=item["tag"]
        #if "creator" in dctag:
            #print (str(child_no) + " " + dctag +"." + mdqualifier + "." + item["text"])
            
        if "parent" in dctag: 
            item["text"] = item["text"]  
            dctag = "relation"
            mdqualifier = "ispartof"
            
        if "date" in dctag:
            dctag = "date"
            mdqualifier = "issued"
        
        if dctag == "identifier" or dctag == "unitid":
            if "http" in item["text"]:
                mdqualifier = "uri"
            else:
                dctag = "identifier"
        
        if dctag == 'p':
            dctag = "description"
                
        if dctag == "link":
            dctag = "identifier"
            mdqualifier = "uri"
            
        if dctag == "imageURI":
            dctag = "identifier"
            mdqualifier = "imageUri"
            print (str(child_no) + " " + dctag +"." + mdqualifier + "." + str(item["text"]))
            

        if "title" in dctag:
            dctag = "title"
            
        #print(dctag + mdqualifier + str(item["text"]) )    
        mdschema = 'dcvalue'
        dcvalue = ETOut.SubElement(outroot, mdschema)
        dcvalue.set('element', dctag)
        dcvalue.set('qualifier', mdqualifier)
        dcvalue.text = item["text"]
    rough_string = ETOut.tostring(outroot, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    pretty_string = reparsed.toprettyxml(indent="\t")
    metadata_file = open(out_file, "w")
    metadata_file.write(pretty_string)
    metadata_file.close()
    return child_no
control()
