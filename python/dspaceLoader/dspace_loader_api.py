"""
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
"""

#global variable definition, general setup
import os
import shutil
import json
import csv
import argparse
from datetime import timedelta, date
from api_variables import ALL_VARS

COLLECTION = ''
ENVIRONMENT = ''
FILTERED = ''
DAYS = ''

PARSER = argparse.ArgumentParser()

PARSER.add_argument('-c', '--collection', action="store", dest="collection", help="collection loading", default="art")
PARSER.add_argument('-e', '--environment', action="store", dest="environment", help="environment- test or live", default="live")
PARSER.add_argument('-f', '--filtered', action="store", dest="filtered", help="filtering of images", default="0")
PARSER.add_argument('-d', '--days', action="store", dest="days", help="number of days", default="1")

ARGS = PARSER.parse_args()

print(ARGS)
COLLECTION = str(ARGS.collection)
ENVIRONMENT = str(ARGS.environment)
FILTERED = str(ARGS.filtered)
DAYS = str(ARGS.days)

print('collection is ' + COLLECTION)
print('environment is ' + ENVIRONMENT)
print('filtering is ' + FILTERED)
print('days is ' + DAYS)

if ENVIRONMENT == 'live':
    ENVIRONMENT = ''
    WEBENV = ''
else:
    WEBENV = ENVIRONMENT + "."

EXISTING_FOLDER = COLLECTION + ALL_VARS['EX_FOLD']
for root, dirs, files in os.walk(EXISTING_FOLDER):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
NEW_FOLDER = COLLECTION +  ALL_VARS['N_FOLD']
for root, dirs, files in os.walk(NEW_FOLDER):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
MAN_FOLDER = COLLECTION + "/manifests"
for root, dirs, files in os.walk(MAN_FOLDER):
    for f in files:
        os.unlink(os.path.join(root, f))
CSV_FILE = open(ALL_VARS['MAP_FILE'], 'r')
MAPPING = csv.DictReader(CSV_FILE, delimiter=':')
MAP_ARRAY = list(MAPPING)
MAP_LEN = len(MAP_ARRAY)

BITSTREAM_DIRECTORY = ALL_VARS['BIT_DIR']

FM = open(COLLECTION + "/" + ENVIRONMENT + "mapfile.txt", "w")

if COLLECTION == 'stcecilia':
    QUERY_PARM = ALL_VARS['ST_CECILIA_QUERY']

if COLLECTION == 'art':
    QUERY_PARM = ALL_VARS['ART_QUERY']

if COLLECTION == 'mimed':
    QUERY_PARM = ALL_VARS['MIMED_QUERY']

if COLLECTION == 'publicart':
    QUERY_PARM = ALL_VARS['PUBLIC_ART_QUERY']

DATE_PERIOD = "days"
START_DATE = date.today() - timedelta(**{DATE_PERIOD: int(DAYS)})
DATE_FORMATTED = START_DATE.strftime("%d %m %Y")
DATE_FORMATTED = DATE_FORMATTED.replace(" ", "%20")

QUERY = '(updatedsince:"' + DATE_FORMATTED + '" AND ' + QUERY_PARM

URL = ALL_VARS['API_URL'] + QUERY +  ALL_VARS['FIELDS'] +  ALL_VARS['LIMIT']

def parse_json(url):
    """
    Get Object info from API and return as json
    :param url: the API URL
    :return data: the returned json
    """
    from urllib.request import FancyURLopener

    class MyOpener(FancyURLopener):
        """
        MyOpener
        """
        version = 'My new User-Agent'

    myopener = MyOpener()
    response = myopener.open(url)
    try:
        data = response.read().decode("utf-8")
        return json.loads(data)
    except Exception:
        print("nothing to run")

def map_md(key, value, et_out, outroot):
    """
    Map found field to its dublin core equivalent, and add to XML tree for the item
    :param key: fieldname
    :param value: field value
    :param et_out: XML Tree before
    :param outroot: dublin core header
    :return et_out: XML Tree with additional entry
    """
    map_row = 0
    while map_row < MAP_LEN:
        if MAP_ARRAY[map_row]['vernon'] == key:
            if 'dc_prod_pri_date' in key:
                value = value[7:]
            mdschema = str(MAP_ARRAY[map_row]['dc'] + "value")
            mdelement = str(MAP_ARRAY[map_row]['element'])
            if MAP_ARRAY[map_row]['qualifier'] == 'noqual':
                mdqualifier = str('')
            else:
                mdqualifier = str(MAP_ARRAY[map_row]['qualifier'])
            if len(value) > 0:
                dcvalue = et_out.SubElement(outroot, mdschema)
                dcvalue.set('element', mdelement)
                dcvalue.set('qualifier', mdqualifier)
                dcvalue.text = value
        map_row = map_row + 1
    return et_out

def get_acc_no(record):
    """
    Get accession no
    :param record: Input record number
    :return: Accession No for use as folder name, etc
    """
    for key, value in record.items():
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
    file_master = open(COLLECTION + "/" + ENVIRONMENT + "mapfile-master.txt")
    for line in file_master.readlines():
        acc_no_len = len(item_acc_no)
        if item_acc_no == line[:acc_no_len]:
            existing = True
            FM.write(line)
        if existing:
            subfolder = EXISTING_FOLDER + item_acc_no
        else:
            subfolder = NEW_FOLDER + item_acc_no
    file_master.close()
    return subfolder

def iiif_md(dealing_image, et_out, outroot, ):
    """
    Generate linkuri for IIIF in MD- no physical images any more
    :param dealing_image: Current image
    :param et_out: XML Tree before
    :param outroot: dublin core header
    :return: XML Tree after
    """
    dcvalue = et_out.SubElement(outroot, 'dcvalue')
    dcvalue.set('element', 'identifier')
    dcvalue.set('qualifier', 'imageUri')
    dcvalue.text = str(dealing_image)
    return et_out

def manifest_url(manifest_array, dealing_image):
    """
    Add image's corresponding manifest to manifest array
    :param manifest_array: manifest array before
    :param dealing_image: current image
    :return: manifest array after
    """
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
    man_id = ''
    type = ''
    context = ''
    related = ''
    from urllib.request import urlopen
    if manifest_count > 0:
        while images < manifest_count:
            response = urlopen(manifest_array[images])
            try:
                resp_data = response.read().decode("utf-8")
                data = json.loads(resp_data)
            except ValueError:
                bad_image_array.append(manifest_array[images])
            else:
                if images == 0:
                    label = data["label"]
                    attribution = data["attribution"]
                    logo = data["logo"]
                    man_id = "http://" + WEBENV + "collections.ed.ac.uk/manifests/" + item_acc_no + ".json"
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
            "@id": man_id,
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
    av_len = len(av_array)
    ani = 0
    while ani < av_len:
        mp3pos = av_array[ani].find('mp3')
        webmpos = av_array[ani].find('webm')
        mp4pos = av_array[ani].find('mp4')
        if (mp3pos > -1) or (webmpos > -1) or (mp4pos > -1):
            for root, dirs, files in os.walk(BITSTREAM_DIRECTORY):
                for _file in files:
                    if _file in av_array[ani]:
                        shutil.copy(os.path.abspath(root + '/' + _file), subfolder)
                        cfile.write(_file + "\n")
                        print("Processed sound or video " + _file)
                        sound_video_amount += 1
        ani = ani + 1
    return sound_video_amount

def write_md_to_file(out_file, et_out, outroot):
    """
    Write the XML tree to the dublin core file
    :param out_file: dublin core file
    :param et_out: XML tree in
    :param outroot: dublin core header
    :return: no return
    """
    from xml.dom import minidom
    rough_string = et_out.tostring(outroot, 'utf-8')
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
        """
        MyOpener
        """
        version = 'My new User-Agent'   # Set this to a string you want for your user agent

    myopener = MyOpener()
    public_image_url = ''
    if coll == 'art':
        public_image_url = ALL_VARS['API_AV_CHECK_URL'] + ALL_VARS['ART_PUBLIC_IMAGES_QUERY'] + ALL_VARS['LIMIT']

    response = myopener.open(public_image_url)
    print("URL" + public_image_url)
    data = response.read().decode("utf-8")
    image_data = json.loads(data)
    images = image_data["_links"]["records"]
    public_image_list = []
    for record in images:
        public_image_list.append(record["title"])
    return public_image_list

def main():
    """
    This is the main processing loop to traverse the API json returned
    """
    if FILTERED == '1':
        public_image_list = get_ok_images(COLLECTION)
    print(URL)
    data = parse_json(URL)
    if data:
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

        while records < data_len:
            id_link = str(data["_embedded"]["records"][records]["_links"]["self"]["href"])
            objectpoint = id_link.find('object')
            system_id = id_link[objectpoint+7:]
            record = data["_embedded"]["records"][records]
            av_array = []
            subfolder = ''

            import xml.etree.cElementTree as et_out
            outroot = et_out.Element(ALL_VARS['DC_HEADER'])

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

            indexed_array = []

            first_image_array = []

            for key, value in record.items():
                twod = False
                if type(value) is list:
                    try:
                        for subkey, subvalue in value[0].items():
                            twod = True
                    except:
                        twod = False
                        for child in value:
                            et_out = map_md(key, child, et_out, outroot)
                    if twod:
                        value_len = len(value)
                        count = 0
                        av_note = 0
                        av_item = ''
                        while count < value_len:
                            av_set = False
                            for subkey, subvalue in value[count].items():
                                if subkey == "av_notes":
                                    av_note = subvalue
                                    av_set = True
                                elif subkey == "av":
                                    av_item = subvalue
                                    av_set = True
                                else:
                                    et_out = map_md(subkey, subvalue, et_out, outroot)
                            if av_set:
                                first_image_array.append({'av':av_item, 'av_note':av_note})
                            count += 1
                else:
                    et_out = map_md(key, value, et_out, outroot)

            for image in first_image_array:
                iiif = False
                iiif_image = ''
                iiif_note = ''
                if "iiif" in image["av"]:
                    htpos = image["av"].find('http')
                    jpgpos = image["av"].find('default.jpg')
                    jpgpos = jpgpos + 11
                    iiif_image = image["av"][htpos:jpgpos]
                    iiif = True
                else:
                    av_array.append(image["av"])

                if image["av_note"] == '':
                    iiif_note = '1'
                elif image["av_note"] == '0':
                    iiif = False
                else:
                    iiif_note = image["av_note"]

                if iiif:
                    indexed_array.append({'iiifurl':iiif_image, 'note':iiif_note})


            sorted_array = sorted(indexed_array, key=lambda dct: dct['note'])
            sorted_len = len(sorted_array)

            sort_item = 0
            manifest_array = []

            while sort_item < sorted_len:
                dealing_image = str(sorted_array[sort_item]['iiifurl'])
                print("working with " + dealing_image)
                if FILTERED == "1":
                    matched = False
                    for ok_image in public_image_list:
                        if dealing_image in ok_image:
                            matched = True
                            et_out = iiif_md(dealing_image, et_out, outroot)
                            manifest_array = manifest_url(manifest_array, dealing_image)
                            image_total += 1
                    if not matched:
                        print("non-public image" + dealing_image)
                else:
                    et_out = iiif_md(dealing_image, et_out, outroot)
                    manifest_array = manifest_url(manifest_array, dealing_image)
                    image_total += 1
                sort_item += 1

            manifest_amount = create_image_manifest(manifest_array, subfolder, cfile, item_acc_no, bad_image_array)
            manifest_total = manifest_total + manifest_amount
            sound_video_total += process_non_image_avs(av_array, subfolder, cfile)
            sound_video_amount = sound_video_total + sound_video_amount
            cfile.close()
            write_md_to_file(out_file, et_out, outroot)
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

        FM.close()
        print('Finished.')

if __name__ == '__main__':
    main()
