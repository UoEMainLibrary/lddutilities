#Script to generate manifest off LUNA collection
from pprint import pprint
import csv
with open('imageinfo.csv', 'rb') as csvfile1:
    shelfreader = csv.DictReader(csvfile1, delimiter=',', quotechar='"')
    shelfarray = list(shelfreader)
    
shelflen = len(shelfarray)
distinctshelfarray = []
manifestsarray = []
import urllib, json

i = 0
#response = ({})
while i <shelflen:
    shelf = shelfarray[i]['shelfmark']
    if shelf is None:
        print "blank shelfmark"
    else:
        if 'Coll' in shelf:
            print shelf + 'not interested'
        else:
                if 'EU' in shelf:
                    print shelf + 'not interested'
                else:    
                    j = 0
                    shelfset = "false"
                    distinctlen = len(distinctshelfarray)
                    while j < distinctlen:
                        if shelf == distinctshelfarray[j]["shelfmark"]:
                            shelfset = "true"
                        j=j+1  
                          
                    if shelfset == "false":
                        distinctshelfarray.append({ "shelfmark": shelf})
    i=i+1
k = 0 

while k < distinctlen + 1:
    shelfusing = distinctshelfarray[k]["shelfmark"]
    print "processing "+ shelfusing
    p = 0
    label = shelfusing.replace(" ","-")
    label = label.replace(".","-")
    label = label.replace("*","-")
    label = label.replace("/","-")
    manifestarray = []
    manifestset = set(manifestarray)
    sequencesarray = []
    sequencesarray.append({ "@type": "sc:Sequence",
                       "viewingHint" : "individual",
                       "canvases" : manifestarray })
    
    while p < shelflen:
        shelf = shelfarray[p]['shelfmark']
        jpegpath = shelfarray[p]['jpeg_path']
        contextstring = ""
        
        if shelfusing == shelf:
            url = jpegpath.replace("detail/", "iiif/m/")
            url = url + "/manifest"
            response = ({})
            response = urllib.urlopen(url)
            data = ''
            data = json.loads(response.read())

            manifestdetail =  data["sequences"][0]["canvases"][0]
            manifest = data["@id"]
            canvas = manifest.replace("manifest", "canvas/c1")
            manifestarray.append(manifestdetail)

            contextstring = data["@context"]  
        p=p+1 
        outdata = ({})
        outdata = { 
           "label" : label,
           "attribution": "Library and University Collections, The University of Edinburgh",
           "logo" : "https://www.eemec.med.ed.ac.uk/img/logo-white.png",
           "@id" : "https://test.librarylabs.ed.ac.uk/manifests/" + label + ".json",
           "related" : jpegpath,
           "sequences" : sequencesarray,
           "@type" : "sc:Manifest",
           "@context" : contextstring
           }
        
        outfile = open('speccollmans/' +label + '.json', 'w')
        json.dump(outdata, outfile)
        outfile.close()
        #response.close()   
    manifestsarray.append({"@id":"https://librarylabs.ed.ac.uk/manifest/" + label + ".json",
                            "label": label + " Images",
                            "@type": "sc:Manifest",
                            "@context": contextstring
                            })
    k = k + 1 
shelfOutData  ={
 "attribution" : "Special Collections",
 "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
 "seeAlso" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "within" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "label": "Meeting Rooms Collection",
 "manifests": manifestsarray,    
 "@type": "sc:Collection",
 "@id": "https://librarylabs.ed.ac.uk/manifest/shelfmarkcollection.json"
}  

collfile = open('shelfmarkcollection.json', 'w')
json.dump(shelfOutData, collfile)
#response.close()      
collfile.close()
print "finished"