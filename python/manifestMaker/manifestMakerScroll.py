#Script to generate manifest off LUNA collection
from pprint import pprint    
import urllib, json
print "Give us a Scroll manifest at collection level"
url = raw_input()
response = urllib.urlopen(url)
data = json.loads(response.read())
pos = data["manifests"][0]["label"].find(":")
label = data["manifests"][0]["label"][:pos]
detailpage = data["manifests"][0]["@id"]
detailpage = detailpage.replace("/iiif/m","/detail")
detailpage = detailpage.replace("/manifest","")
manifestarray = []
manifestset = set(manifestarray)
sequencesarray = []
sequencesarray.append({ "@type": "sc:Sequence",
                       "viewingHint" : "continuous",
                       "viewingDirection" : "top-to-bottom",
                       "canvases" : manifestarray })

manifestseqarray = []
for item in data["manifests"]:
    labelseq = item["label"][27:].zfill(3)
    manifestseqarray.append({ "seq": labelseq,
                       "@id" : item["@id"]})

sortedmans = []
sortedmans = sorted(manifestseqarray,key=lambda dct: dct['seq'])
    
i = 0
for item in sortedmans:
    import urllib, json
    murl = item["@id"]
    response = urllib.urlopen(murl)
    mdata = json.loads(response.read())
    height = mdata["sequences"][0]["canvases"][0]["height"]
    width = mdata["sequences"][0]["canvases"][0]["width"]
    thumbnail =  mdata["sequences"][0]["canvases"][0]["thumbnail"]
    manifestdetail =  mdata["sequences"][0]["canvases"][0]
    manifest = item["@id"]
    canvas = manifest.replace("manifest", "canvas/c1")
    manifestarray.append(manifestdetail)
    i=i+1 
    
    
    
outdata = { 
           "label" : label,
           "attribution": data["attribution"],
           "logo" : data["logo"],
           "@id" : "https://librarylabs.ed.ac.uk/mahabharataScroll.json",
           "related" : detailpage,
           "sequences" : sequencesarray,
           "@type" : "sc:Manifest",
           "@context" : data["manifests"][0]["@context"]
           }

#outdata["attribution"] = data["attribution"]

import json
with open('mahabharataScroll.json', 'w') as outfile:
    json.dump(outdata, outfile)

print "finished"
#if __name__ == "__main__":
#   main();