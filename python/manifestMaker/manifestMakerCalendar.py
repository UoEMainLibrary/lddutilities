#Script to generate manifest off LUNA collection
def takelabel(manifestsarray):
    return manifestsarray["label"]

from pprint import pprint    

import csv
with open('Calendar.csv', 'rb') as csvfile1:
    roomreader = csv.DictReader(csvfile1, delimiter=',', quotechar='"')
    roomarray = list(roomreader)
    
roomlen = len(roomarray)

distinctroomarray = []
manifestsarray = []
import urllib, json

i = 0
while i <roomlen:
    room = roomarray[i]['Room']
    image = roomarray[i]['Image'
                         ]
    url = str("https://images.is.ed.ac.uk/luna/servlet/iiif/m/" + image + "/manifest")
    print url
    response = ''
    response = urllib.urlopen(url)
    data = ''
    data = json.loads(response.read())
    manifestdetail =  data["sequences"][0]["canvases"][0]
    manifest = data["@id"]
    canvas = manifest.replace("manifest", "canvas/c1")
    manifestsarray.append(manifestdetail)
    context = data["@context"]
    manifestsarray.append({"@id": url,
                            "label":" Images" + room,
                            "@type": "sc:Manifest",
                            "@context": context
                            })
    i=i+1

manifestsarray.sort(key=takelabel)
roomOutData  ={
 "attribution" : "Meeting Rooms Collection",
 "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
 "seeAlso" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "within" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "label": "Meeting Rooms Collection",
 "manifests": manifestsarray,    
 "@type": "sc:Collection",
 "@id": "https://librarylabs.ed.ac.uk/manifest/RoomCollection.json"
}  

outfile = open('Calendar2015.json', 'w')
json.dump(roomOutData, outfile)
response.close()        
print "finished"

