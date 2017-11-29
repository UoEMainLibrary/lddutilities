#Script to generate manifest off LUNA collection
from pprint import pprint    

import csv
with open('Rooms.csv', 'rb') as csvfile1:
    roomreader = csv.DictReader(csvfile1, delimiter=',', quotechar='"')
    roomarray = list(roomreader)
    
roomlen = len(roomarray)

distinctroomarray = []
manifestsarray = []
import urllib, json

i = 0
while i <roomlen:
    room = roomarray[i]['Room']
    j = 0
    roomset = "false"
    distinctlen = len(distinctroomarray)
    while j < distinctlen:
        if room == distinctroomarray[j]["Room"]:
            roomset = "true"
        j=j+1    
    if roomset == "false":
        distinctroomarray.append({ "Room": room})
    i=i+1

k = 0 

while k < distinctlen:
    roomusing = distinctroomarray[k]["Room"]
    i = 0
    image = roomarray[i]['Image']
    label = roomusing.replace("_"," ")+")"
    label = label.replace(":"," (")
    detailpage = "https://images.is.ed.ac.uk/luna/servlet/detail/" + image
    detailpage = detailpage.replace("/iiif/m","/detail")
    detailpage = detailpage.replace("/manifest","")
    manifestarray = []
    manifestset = set(manifestarray)
    sequencesarray = []
    sequencesarray.append({ "@type": "sc:Sequence",
                       "viewingHint" : "individual",
                       "canvases" : manifestarray })
    roomusing = roomusing.rpartition(':')[0]
    while i < roomlen:
        room = roomarray[i]['Room'].rpartition(":")[0]
        if roomusing == room:
            url = "https://images.is.ed.ac.uk/luna/servlet/iiif/m/" + roomarray[i]["Image"] + "/manifest"
            print url
            response = ''
            response = urllib.urlopen(url)
            data = ''
            data = json.loads(response.read())
            manifestdetail =  data["sequences"][0]["canvases"][0]
            manifest = data["@id"]
            canvas = manifest.replace("manifest", "canvas/c1")
            manifestarray.append(manifestdetail)
            context = data["@context"]
        i=i+1 

        outdata = { 
           "label" : label,
           "attribution": "Library and University Collections, The University of Edinburgh",
           "logo" : "https://www.eemec.med.ed.ac.uk/img/logo-white.png",
           "@id" : "https://test.librarylabs.ed.ac.uk/manifests/" + roomusing + ".json",
           "related" : detailpage,
           "sequences" : sequencesarray,
           "@type" : "sc:Manifest",
           "@context" : context
           }
        
        outfile = open(roomusing + '.json', 'w')
        json.dump(outdata, outfile)
        response.close()   
    manifestsarray.append({"@id":"https://librarylabs.ed.ac.uk/manifest/" + roomusing + ".json",
                            "label": label + " Images",
                            "@type": "sc:Manifest",
                            "@context": context
                            })
    k = k + 1 
roomOutData  ={
 "attribution" : "Rooms Floor E",
 "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
 "seeAlso" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "within" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "label": "Meeting Rooms Collection",
 "manifests": manifestsarray,    
 "@type": "sc:Collection",
 "@id": "https://librarylabs.ed.ac.uk/manifest/RoomCollection.json"
}  

outfile = open('RoomCollection.json', 'w')
json.dump(roomOutData, outfile)
response.close()        
print "finished"