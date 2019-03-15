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
from luna_from_vernon_variables import ALL_VARS

COLLECTION = ''
ENVIRONMENT = ''
FILTERED = ''
DAYS = ''

PARSER = argparse.ArgumentParser()

PARSER.add_argument('-c', '--collection', action="store", dest="collection", help="collection loading", default="art")
PARSER.add_argument('-e', '--environment', action="store", dest="environment", help="environment- test or live", default="live")
PARSER.add_argument('-d', '--days', action="store", dest="days", help="number of days", default="1")

ARGS = PARSER.parse_args()

print(ARGS)
COLLECTION = str(ARGS.collection)
ENVIRONMENT = str(ARGS.environment)
DAYS = str(ARGS.days)

print('collection is ' + COLLECTION)
print('environment is ' + ENVIRONMENT)
print('days is ' + DAYS)

if ENVIRONMENT == 'live':
    ENVIRONMENT = ''
    WEBENV = ''
else:
    WEBENV = ENVIRONMENT + "."

CSV_FILE = open(ALL_VARS['MAP_FILE'], 'r')
MAPPING = csv.DictReader(CSV_FILE, delimiter=':')
MAP_ARRAY = list(MAPPING)
MAP_LEN = len(MAP_ARRAY)

if COLLECTION == 'art':
    QUERY_PARM = ALL_VARS['ART_QUERY']

if COLLECTION == 'mimed':
    QUERY_PARM = ALL_VARS['MIMED_QUERY']

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

def map_md(key, value, flat_array):
    """
    Map found field to its dublin core equivalent, and add to XML tree for the item
    :param key: fieldname
    :param value: field value
    :param flat_array: ungrouped metadata list
    :return flat_array with appended data
    """
    map_row = 0
    while map_row < MAP_LEN:
        if len(value) > 0:
            if MAP_ARRAY[map_row]['vernon'] == key:
                flat_array.append({'field_group':str(MAP_ARRAY[map_row]['field_group']), 'field':str(MAP_ARRAY[map_row]['field']), 'value':str(value)})
        map_row = map_row + 1
    return flat_array

def write_md_to_file(out_file, ET, root):
    """
    Write the XML tree to the dublin core file
    :param out_file: dublin core file
    :param et_out: XML tree in
    :param outroot: dublin core header
    :return: no return
    """
    from xml.dom import minidom
    rough_string = ET.tostring(root, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    pretty_string = reparsed.toprettyxml(indent="\t")
    import codecs
    with codecs.open(out_file, "w", encoding='utf-8') as file:
        file.write(pretty_string)
    file.close()


def main():
    """
    This is the main processing loop to traverse the API json returned
    """
    print(URL)
    data = parse_json(URL)
    if data:
        records = 0
        data_len = len(data["_embedded"]["records"])
        print("Processing " + str(data_len) + "records")
        bad_im_ref_array = []
        bad_work_record_id_array = []
        bad_accession_no_array = []

        import xml.etree.cElementTree as ET
        root = ET.Element("recordList")

        while records < data_len:
            record = data["_embedded"]["records"][records]
            id_link = str(data["_embedded"]["records"][records]["_links"]["self"]["href"])
            objectpoint = id_link.find('av')
            system_id = str(id_link[objectpoint+3:])
            doc = ET.SubElement(root, "record")
            flat_array = []
            set_field_groups = []
            accession_ok = False
            work_record_id_ok = False
            im_ref_ok = False
            for key, value in record.items():
                twod = False
                if type(value) is list:
                    try:
                        for subkey, subvalue in value[0].items():
                            twod = True
                    except:
                        twod = False
                        for child in value:
                            flat_array = map_md(key, child, flat_array)
                    if twod:
                        value_len = len(value)
                        count = 0
                        while count < value_len:
                            flat_array = map_md(subkey, subvalue, flat_array)
                            count += 1
                else:
                    flat_array = map_md(key, value, flat_array)
            for item in flat_array:
                if item["field"] == "work_catalogue_number":
                    accession_ok = True
                if item["field"] == "work_record_id":
                    work_record_id_ok = True
                if item["field"] == "repro_id_number":
                    im_ref_ok = True

            if not im_ref_ok:
                bad_im_ref_array.append(str(system_id))
            if not work_record_id_ok:
                bad_work_record_id_array.append(str(system_id))
            if not accession_ok:
                bad_accession_no_array.append(str(system_id))


            for item in flat_array:
                if accession_ok and work_record_id_ok and im_ref_ok:
                    if item["field_group"] == 'none':
                        field = ET.SubElement(doc, "field")
                        field.set("name", item["field"])
                        value = ET.SubElement(field, "value")
                        value.text= item["value"]
                    else:
                        group_set = False
                        for group in set_field_groups:
                            if item["field_group"] == group:
                                group_set = True
                        if not group_set:
                            set_field_groups.append(item["field_group"])
                            field_group = ET.SubElement(doc, "entity")
                            field_group.set("name", item["field_group"])
                        field = ET.SubElement(field_group, "field")
                        field.set("name", item["field"])
                        value = ET.SubElement(field, "value")
                        value.text= item["value"]

            records += 1

        #print(ET.dump(root))

        import time
        time_str = time.strftime("%Y%m%d-%H%M%S")

        out_file = "output/luna_md-" + time_str + ".xml"

        write_md_to_file(out_file, ET, root)

        print('Processed ' + str(records) + ' items.')
        print('Skipped ' + str(len(bad_accession_no_array)) + ' records with no accession number.')
        print('Skipped ' + str(len(bad_work_record_id_array)) + ' records with no work record id.')
        print('Skipped ' + str(len(bad_im_ref_array)) + ' records with no digital filename.')
        for bad_acc in bad_accession_no_array:
            print("System ID to check (accession no): " + str(bad_acc))
        for bad_work in bad_work_record_id_array:
            print("System ID to check (av link id): " + str(bad_work))
        for bad_image in bad_im_ref_array:
            print("Image dead: " + str(bad_image))
        print('Finished.')

if __name__ == '__main__':
    main()
