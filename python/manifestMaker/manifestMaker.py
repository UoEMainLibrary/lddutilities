#Script to generate manifest off LUNA collection
from pprint import pprint    
import urllib, json
print "Give us a manifest at collection level"
url = raw_input()
response = ''

response = urllib.urlopen(url)
print response.info()
print str(response)
data = ''
data = json.loads(response.read())

print str(data)
pos = data["manifests"][0]["label"].find(":")
label = data["manifests"][0]["label"][:pos]
detailpage = data["manifests"][0]["@id"]
detailpage = detailpage.replace("/iiif/m","/detail")
detailpage = detailpage.replace("/manifest","")
manifestarray = []
manifestset = set(manifestarray)
sequencesarray = []
sequencesarray.append({ "@type": "sc:Sequence",
                       "viewingHint" : "individual",
                       "canvases" : manifestarray })


i = 0

for item in data["manifests"]:
    import urllib, json
    murl = item["@id"]
    response = urllib.urlopen(murl)
    mdata = json.loads(response.read())
    manifestdetail =  mdata["sequences"][0]["canvases"][0]
    manifest = item["@id"]
    canvas = manifest.replace("manifest", "canvas/c1")
    manifestarray.append(manifestdetail)

  
    i=i+1 
    
    
outdata = { 
           "label" : label,
           "attribution": data["attribution"],
           "logo" : data["logo"],
           "@id" : "https://testlibrarylabs.ed.ac.uk/manifests/manifestPolyannoContent.json",
           "related" : detailpage,
           "sequences" : sequencesarray,
           "@type" : "sc:Manifest",
           "@context" : data["manifests"][0]["@context"]
           }

import json
with open('manifestPolyannoContent.json', 'w') as outfile:
    json.dump(outdata, outfile)
response.close()
print "finished"
#if __name__ == "__main__":
#   main();