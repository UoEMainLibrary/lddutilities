# Scott Renton, Feb 2019
# Vernon-dSpace Loader prep for Skylight
# Interrogates API, pulls out relevant Vernon data
# and generates:
#    dublin core metadata
#    IIIF images
#    IIIF manifests
#    non-image AVs
#    contents file
# For use with classic dspace import
# Based upon items updated since previous run.

#global variable definition, general setup

from api_variables import ALL_VARS
import os
import shutil
import json
import csv
import argparse

collection = ''
environment = ''
filtered = ''


parser = argparse.ArgumentParser()
parser.add_argument('-c', '--collection',
            action="store", dest="collection",
            help="collection loading", default="spam")
parser.add_argument('-e', '--environment',
            action="store", dest="environment",
            help="environment- test or live", default="spam")
parser.add_argument('-f', '--filtered',
            action="store", dest="filtered",
            help="filtering of images", default="spam")
args = parser.parse_args()

print(args)
collection= str(args.collection)
environment =str(args.environment)
filtered =str(args.filtered)

print ('collection is '+ collection)
print ('environment is ' + environment)
print ('filtering is ' + filtered)

if environment == 'live':
    environment = ''
    webenv = ''
else:
    webenv = environment + "."

existingfolder = collection + ALL_VARS['EX_FOLD']
for root, dirs, files in os.walk(existingfolder):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
newfolder = collection +  ALL_VARS['N_FOLD']
for root, dirs, files in os.walk(newfolder):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
man_folder = collection + "/manifests"
for root, dirs, files in os.walk(man_folder):
    for f in files:
        os.unlink(os.path.join(root, f))
csvfile2 = open(ALL_VARS['MAP_FILE'], 'r')
mapping = csv.DictReader(csvfile2, delimiter=':')
maparray = list(mapping)
maplen = len(maparray)

bitstream_directory = ALL_VARS['BIT_DIR']

fm = open(collection + "/" + environment + "mapfile.txt", "w")

if collection == 'stcecilia':
    query_parm = 'slist:"StCeciliasItems")'

import datetime
from dateutil.relativedelta import relativedelta

yesterday = datetime.datetime.now() - relativedelta(months=2)
date_formated = yesterday.strftime("%d %m %Y")

query = '(updatedsince:"' + date_formated + '" AND ' + query_parm

url = ALL_VARS['API_URL'] + query +  ALL_VARS['FIELDS'] +  ALL_VARS['LIMIT']

def parse_json(url):
    """
    Get Object info from API and return as json
    :param url: the API URL
    :return data: the returned json
    """
    from urllib.request import FancyURLopener

    class MyOpener(FancyURLopener):
        version = 'My new User-Agent'

    myopener = MyOpener()
    import json

    response = myopener.open(url)
    data = response.read().decode("utf-8")
    return json.loads(data)

def map_md(key,value, ETOut, outroot):
    """
    Map found field to its dublin core equivalent, and add to XML tree for the item
    :param key: fieldname
    :param value: field value
    :param ETOut: XML Tree before
    :param outroot: dublin core header
    :return ETOut: XML Tree with additional entry
    """
    m = 0
    while m < maplen:
        if maparray[m]['vernon'] == key:
            if 'dc_prod_pri_date' in key:
                value=value[7:]
            mdschema = str(maparray[m]['dc'] + "value")
            mdelement = str(maparray[m]['element'])
            if maparray[m]['qualifier'] == 'noqual':
                mdqualifier = str('')
            else:
                mdqualifier = str(maparray[m]['qualifier'])
            dcvalue = ETOut.SubElement(outroot, mdschema)
            dcvalue.set('element', mdelement)
            dcvalue.set('qualifier', mdqualifier)
            dcvalue.text = value
        m = m + 1
    return ETOut

def get_acc_no(record):
    """
    Get accession no
    :param record: Input record number
    :return: Accession No for use as folder name, etc
    """
    for key,value in record.items():
        if key == "accession_no":
            if 'L' in value:
                value = value[2:]
            if '/' in value:
                value = value.replace('/', '-')
            if ',' in value:
                value = value[:4]
            if '@' in value:
                value = value[:4]
            item_acc_no = value
    return item_acc_no

def get_subfolder(item_acc_no):
    """
    Get subfolder for accession no, depending on whether exists or not
    :param item_acc_no:  accession no
    :return: subfolder will be path including existing or new
    """
    existing = False
    f = open(collection + "/" + environment + "mapfile-master.txt")
    for line in f.readlines():
        acc_no = line.split(' ')[0]
        if item_acc_no == acc_no:
            existing = True
            fm.write(line)
        if existing == True:
            subfolder = existingfolder + item_acc_no
        else:
            subfolder = newfolder + item_acc_no
    return subfolder

def build_image_array(image_array, subvalue, tag_id):
    """
    Build up array of IIIF IDs
    :param image_array: Array of images for item before
    :param subvalue: Image URL
    :param tag_id: Number of images thus far
    :return: Image array appended to
    """
    htpos = subvalue.find('http')
    jpgpos = subvalue.find('default.jpg')
    jpgpos = jpgpos + 11
    iiifurl = subvalue[htpos:jpgpos]
    image_array.append({"row": tag_id,
                        "iiifurl": iiifurl})
    return image_array

def build_indexed_array(image_array, av_notes_array):
    """
    Build 2D Array with images and position it should appear (in av notes)
    :param image_array: Full list of images for item
    :param av_notes_array: Full list of AV notes for item
    :return: 2 Array of images and positions
    """
    image_array_len = len(image_array)
    av_notes_array_len = len(av_notes_array)
    item = 0
    indexed_array = []
    while item < image_array_len:
        note_item = 0
        if av_notes_array_len > 0:
            while note_item < av_notes_array_len:
                try:
                    note_no = int(av_notes_array[note_item]['note'])
                except ValueError:
                    print("note not a number")
                else:
                    if image_array[item]['row'] == av_notes_array[note_item]['row'] and note_no > 0:
                        indexed_array.append({"iiifurl": image_array[item]['iiifurl'], 'note': av_notes_array[note_item]['note']})
                    note_item += 1
        else:
            indexed_array.append({"iiifurl": image_array[item]['iiifurl'],
                             'note': '1'})
        item += 1
    return indexed_array

def iiif_md(dealing_image, ETOut, outroot, ):
    """
    Generate linkuri for IIIF in MD- no physical images any more
    :param dealing_image: Current image
    :param ETOut: XML Tree before
    :param outroot: dublin core header
    :return: XML Tree after
    """
    dcvalue = ETOut.SubElement(outroot, 'dcvalue')
    dcvalue.set('element', 'identifier')
    dcvalue.set('qualifier', 'imageUri')
    dcvalue.text = str(dealing_image)
    return ETOut

def manifest_url(manifest_array, dealing_image):
    """
    Add image's corresponding manifest to manifest array
    :param manifest_array: manifest array before
    :param dealing_image: current image
    :return: manifest array after
    """
    print(dealing_image)
    iiif_manifest = dealing_image.replace('http', 'https')
    iiif_manifest = iiif_manifest.replace("/iiif/", "/iiif/m/")
    iiif_manifest = iiif_manifest.replace("full/full/0/default.jpg", "manifest")
    print('Image passed: ' + iiif_manifest)
    manifest_array.append(iiif_manifest)
    return manifest_array

def create_image_manifest(manifest_array, subfolder, cfile, item_acc_no, bad_image_array):
    """
    Generate a manifest for the record if min 1 image associated
    :param manifest_array: all valid image individual manifests
    :param subfolder: path to put in
    :param cfile: contents file (list of ass'd files)
    :param item_acc_no: accession no- we need to label it something (not right! but for new stuff, we cannot predict)
    :param bad_image_array: bad images noted here
    :param manifest_total: running total of manifests produced
    :return: manifest_total
    """
    manifest_amount = 0
    manifest_count = len(manifest_array)
    images = 0
    canvases_array = []
    sequences_array = []
    label = ''
    attribution = ''
    logo = ''
    id = ''
    type = ''
    context = ''
    related = ''
    from urllib.request import urlopen
    if manifest_count > 0:
        while images < manifest_count:
            response = urlopen(manifest_array[images])
            try:
                data = json.loads(response.read())
            except ValueError:
                bad_image_array.append(manifest_array[images])
            else:
                if images == 0:
                    label = data["label"]
                    attribution = data["attribution"]
                    logo = data["logo"]
                    id = "http://" + webenv + "collections.ed.ac.uk/manifests/" + item_acc_no + ".json"
                    type = "sc:Manifest"
                    context = data["@context"]
                    related = data["@id"]
                canvas_array = data["sequences"][0]["canvases"][0]
                canvases_array.append(canvas_array)
            images = images + 1
        sequences_array.append({"@type": "sc:Sequence",
                                "viewingHint": "individuals",
                                "canvases": canvases_array})
        outdata = {
            "label": label,
            "attribution": attribution,
            "logo": logo,
            "@id": id,
            "related": related,
            "sequences": sequences_array,
            "@type": type,
            "@context": context
        }
        manifest_loc = subfolder + '/manifest.json'
        with open(manifest_loc, 'w') as jsonfile:
            json.dump(outdata, jsonfile)
        cfile.write('manifest.json' + "\n")
        manifest_amount += 1
    return manifest_amount

def process_non_image_avs(av_array, subfolder, cfile):
    """
    Process video and audio
    :param av_array: Input list of non-image media
    :param subfolder: Path to put in
    :param cfile: Contents file (list of ass'd media)
    :param sound_video_total: Running total of non-image media
    :return: sound_video_total
    """
    sound_video_amount = 0
    print(av_array)
    av_len = len(av_array)
    ani = 0
    while ani < av_len:
        mp3pos = av_array[ani].find('mp3')
        webmpos = av_array[ani].find('webm')
        mp4pos = av_array[ani].find('mp4')
        if (mp3pos > -1) or (webmpos > -1) or (mp4pos > -1):
            for root, dirs, files in os.walk(bitstream_directory):
                for _file in files:
                    if _file in av_array[ani]:
                        shutil.copy(os.path.abspath(root + '/' + _file), subfolder)
                        cfile.write(_file + "\n")
                        print("Processed sound or video " + _file)
                        sound_video_amount += 1
        ani = ani + 1
    return sound_video_amount

def write_md_to_file(out_file, ETOut, outroot):
    """
    Write the XML tree to the dublin core file
    :param out_file: dublin core file
    :param ETOut: XML tree in
    :param outroot: dublin core header
    :return: no return
    """
    from xml.dom import minidom
    rough_string = ETOut.tostring(outroot, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    pretty_string = reparsed.toprettyxml(indent="\t")
    import codecs
    with codecs.open(out_file, "w", encoding='utf-8') as file:
        file.write(pretty_string)
    file.close()

def get_ok_images(coll):
    '''
    Get JSON for OK images for collection and turn into list to check against
    :param coll: collection
    :return: list of ok images
    '''
    from urllib.request import FancyURLopener

    class MyOpener(FancyURLopener):
        version = 'My new User-Agent'   # Set this to a string you want for your user agent

    myopener = MyOpener()
    import json

    response = myopener.open(ALL_VARS['API_AV_CHECK_URL'])
    data = response.read().decode("utf-8")
    image_data = json.loads(data)
    records = 0
    images = len[image_data]
    while records < images:
        pub_status = data["_embedded"]["records"][records]["publication_status"]
        im_ref =  data["_embedded"]["records"][records]["im_ref_group"]["im_ref"]
        collection= data["_embedded"]["records"][records]["im_ref_group"]["collection"]

        if coll in collection and "Full" in pub_status:
            print("ok")

def main():
    """
    This is the main processing loop to traverse the API json returned
    """
    data=parse_json(url)
    records = 0
    data_len = len(data["_embedded"]["records"])
    print("Processing " + str(data_len) + "records")
    bad_acc_no_array = []
    bad_image_array = []
    duplicate_array = []
    sound_video_total = 0
    sound_video_amount = 0
    manifest_total = 0
    manifest_amount = 0
    image_total = 0

    if filtered == 1:
        #ok_image_list = get_ok_images()
        print("ich bin filtered")

    while records < data_len:
        id_link = str(data["_embedded"]["records"][records]["_links"]["self"]["href"])
        objectpoint = id_link.find('object')
        system_id = id_link[objectpoint+7:]
        record = data["_embedded"]["records"][records]
        image_array = []
        av_array = []
        av_notes_array = []
        subfolder = ''

        import xml.etree.cElementTree as ETOut
        outroot = ETOut.Element(ALL_VARS['DC_HEADER'])

        item_acc_no = get_acc_no(record)

        print("working with ACC_NO " + item_acc_no + " (VERNON SYSTEM ID " + system_id +")")

        try:
            subfolder = get_subfolder(item_acc_no)
        except Exception:
            print("bad accession no")
            bad_acc_no_array.append(system_id)

        if os.path.exists(subfolder):
            duplicate_array.append(item_acc_no)
        else:
            os.makedirs(subfolder)
            os.chmod(subfolder, 0o777)
            out_file = subfolder + "/dublin_core.xml"
            contentsfile = subfolder + "/contents"
            cfile = open(contentsfile, "w")

        print("Writing to " + out_file)

        for key,value in record.items():
            twod = False
            if len(value) > 0:
                if type(value) is list:
                    try:
                        for subkey,subvalue in value[0].items():
                            twod = True
                    except:
                        twod = False
                        for child in value:
                            ETOut=map_md(key,child,ETOut, outroot)
                    if twod:
                        value_len = len(value)
                        count = 0
                        while count < value_len:
                            for subkey,subvalue in value[count].items():
                                if subkey == 'av':
                                    if 'iiif' in subvalue:
                                        image_array = build_image_array(image_array, subvalue, count)
                                    else:
                                        av_array.append(subvalue)
                                elif subkey == 'av_notes':
                                    av_notes_array.append({"row": count,
                                                        "note": subvalue})
                                else:
                                    ETOut=map_md(subkey, subvalue, ETOut, outroot)
                            count+=1
                else:
                    ETOut=map_md(key, value, ETOut, outroot)

        indexed_array = build_indexed_array(image_array, av_notes_array)

        sorted_array = sorted(indexed_array, key=lambda dct: dct['note'])

        sorted_len = len(sorted_array)

        sort_item = 0
        manifest_array = []

        while sort_item < sorted_len:
            aok = 0
            dealing_image = str(sorted_array[sort_item]['iiifurl'])
            if filtered == '1':
                f = open(collection + "/okimages.txt")

                for ok_image in f.readlines():
                    if dealing_image in ok_image:
                        ETOut = iiif_md(dealing_image, ETOut, outroot)
                        manifest_array = manifest_url(manifest_array, dealing_image)
                        image_total += 1
                    else:
                        print("non-public-image"+ dealing_image)
                aok += 1
                f.close()
            else:
                ETOut = iiif_md(dealing_image, ETOut, outroot)
                manifest_array = manifest_url(manifest_array, dealing_image)
                image_total += 1
            sort_item += 1

        manifest_amount = create_image_manifest(manifest_array, subfolder, cfile,  item_acc_no, bad_image_array)
        manifest_total = manifest_total + manifest_amount
        sound_video_total += process_non_image_avs(av_array, subfolder, cfile)
        sound_video_amount = sound_video_total + sound_video_amount
        cfile.close()
        write_md_to_file(out_file, ETOut, outroot)
        records += 1

    print('Processed ' + str(records) + ' items.')
    print('Processed ' + str(image_total) + ' IIIF images.')
    print('Processed ' + str(sound_video_total) + ' non-image media.')
    print('Processed ' + str(manifest_total) + ' IIIF manifests.')
    print('Skipped ' + str(len(bad_acc_no_array)) + ' records with no accession number.')
    print('Skipped ' + str(len(duplicate_array)) + ' duplicate accession numbers.')
    for badacc in bad_acc_no_array:
        print("System ID to check: " + badacc)
    for dupacc in duplicate_array:
        print("Dup image: " + dupacc)
    for badimage in bad_image_array:
        print("Image dead: " + badimage)

    fm.close()
    print('Finished.')

if __name__ == '__main__':
    main()