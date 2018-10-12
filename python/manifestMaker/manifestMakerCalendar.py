#Script to generate manifest off LUNA collection
#missing images:   
#  12! September    Natural World 2007    http://hdl.handle.net/10683/22075    NOTHING DOING    Sep-07    Two European species of dormice
#     15! December    Travel 2008    http://hdl.handle.net/10683/19408    NAE SIGN    Dec-08    The Balloon 'La Minerve'
def takelabel(manifestsarray):
    return manifestsarray["label"]

from pprint import pprint    

import csv
with open('Calendar.csv', 'rb') as csvfile1:
    yearreader = csv.DictReader(csvfile1, delimiter=',', quotechar='"')
    yeararray = list(yearreader)
    
yearlen = len(yeararray)

distinctyeararray = []
manifestsarray = []
import urllib, json, os

i = 0
while i <yearlen:
    year = yeararray[i]['Calendar']
    j = 0
    yearset = "false"
    distinctlen = len(distinctyeararray)
    while j < distinctlen:
        if year == distinctyeararray[j]["Calendar"]:
            yearset = "true"
        j=j+1    
    if yearset == "false":
        distinctyeararray.append({ "Calendar": year})
    i=i+1

k = 0
while k < distinctlen:
    yearusing = distinctyeararray[k]["Calendar"]
    yearusing = yearusing.replace(" ", "_")
    m = 0
    image = yeararray[m]['Image']
    label = distinctyeararray[k]["Calendar"]
    #label = label.replace(":"," (")
    detailpage = "https://images.is.ed.ac.uk/luna/servlet/detail/" + image
    detailpage = detailpage.replace("/iiif/m","/detail")
    detailpage = detailpage.replace("/manifest","")
    manifestarray = []
    manifestset = set(manifestarray)
    sequencesarray = []
    sequencesarray.append({ "@type": "sc:Sequence",
                       "viewingHint" : "individual",
                       "canvases" : manifestarray })
    while m <yearlen:
        year = yeararray[m]['Calendar']
        year = year.replace(" ", "_")
        image = yeararray[m]['Image']
        individual = yeararray[m]['Individual']
        manname = individual.split("! ")[0]
        manmonth = individual.split("! ")[1]
        
        if yearusing == year:
            url = "https://images.is.ed.ac.uk/luna/servlet/iiif/m/" + yeararray[m]["Image"] + "/manifest"
            response = ''
            response = urllib.urlopen(url)
            data = ''
            data = json.loads(response.read())
            #data["label"] =  manmonth
            #pos = year.find('2')
            #calyear = year[pos:pos+4]
            #if not os.path.exists('calendars/'+calyear):
            #    os.makedirs('calendars/'+calyear)
            #outfile = open('calendars/'+calyear+'/'+manname+'.json', 'w') 
            #json.dump(data, outfile)   
            manifestdetail =  data["sequences"][0]["canvases"][0]
            manifestdetail['label'] = manmonth
            manifest = data["@id"]
            canvas = manifest.replace("manifest", "canvas/c1")
            manifestarray.append(manifestdetail)
            context = data["@context"]
        m=m+1

        outdata = { 
           "label" : label,
           "attribution": "Library and University Collections, The University of Edinburgh",
           "logo" : "https://www.eemec.med.ed.ac.uk/img/logo-white.png",
           "@id" : "https://librarylabs.ed.ac.uk/iiif/manifest/calendars/" + yearusing + ".json",
           "related" : detailpage,
           "sequences" : sequencesarray,
           "@type" : "sc:Manifest",
           "@context" : context
           }
        
       
        outfile = open('calendars/'+yearusing + '.json', 'w')
        json.dump(outdata, outfile)
        response.close()  
    manifestsarray.append({"@id":"https://librarylabs.ed.ac.uk/iiif/manifest/calendars/" + yearusing + ".json",
                            "label": label,
                            "@type": "sc:Manifest",
                            "@context": context
                            })
    k = k + 1 
roomOutData  ={
 "attribution" : "Calendars",
 "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
 "seeAlso" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "within" : "https://images.is.ed.ac.uk/luna/servlet/iiif/collection/g/448",
 "label": "Meeting Rooms Collection",
 "manifests": manifestsarray,    
 "@type": "sc:Collection",
 "@id": "https://librarylabs.ed.ac.uk/iiif/manifest/calendars/CalendarCollection.json"
}  

outfile = open('calendars/CalendarCollection.json', 'w')
json.dump(roomOutData, outfile)
response.close()        
print "finished"