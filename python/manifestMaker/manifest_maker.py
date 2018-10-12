#Script to generate manifest off LUNA collection
#from pprint import pprint
import urllib
import json
print "Give us a manifest at collection level"
URL = raw_input()
RESPONSE = ''

RESPONSE = urllib.urlopen(URL)
print RESPONSE.info()
print str(RESPONSE)
DATA = ''
DATA = json.loads(RESPONSE.read())

print str(DATA)
POS = DATA["manifests"][0]["label"].find(":")
LABEL = DATA["manifests"][0]["label"][:POS]
DETAIL_PAGE = DATA["manifests"][0]["@id"]
DETAIL_PAGE = DETAIL_PAGE.replace("/iiif/m", "/detail")
DETAIL_PAGE = DETAIL_PAGE.replace("/manifest", "")
MANIFEST_ARRAY = []
MANIFEST_SET = set(MANIFEST_ARRAY)
SEQUENCES_ARRAY = []
SEQUENCES_ARRAY.append({"@type": "sc:Sequence",
                        "viewingHint" : "individual",
                        "canvases" : MANIFEST_ARRAY})

i = 0

for item in DATA["manifests"]:
    murl = item["@id"]
    response = urllib.urlopen(murl)
    mdata = json.loads(RESPONSE.read())
    manifestdetail = mdata["sequences"][0]["canvases"][0]
    manifest = item["@id"]
    canvas = manifest.replace("manifest", "canvas/c1")
    MANIFEST_ARRAY.append(manifestdetail)


    i = i+1

OUT_DATA = {
    "label" : LABEL,
    "attribution": DATA["attribution"],
    "logo" : DATA["logo"],
    "@id" : "https://testlibrarylabs.ed.ac.uk/manifests/manifestPolyannoContent.json",
    "related" : DETAIL_PAGE,
    "sequences" : SEQUENCES_ARRAY,
    "@type" : "sc:Manifest",
    "@context" : DATA["manifests"][0]["@context"]
    }

import json
with open('manifestPolyannoContent.json', 'w') as outfile:
    json.dump(OUT_DATA, outfile)
response.close()
print "finished"
