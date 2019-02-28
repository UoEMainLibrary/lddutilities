# Scott Renton, May 2017
# Vernon-dSpace Loader prep for Skylight
# Reads Vernon XML file and processes
#    dublin core metadata
#    IIIF images
#    IIIF manifests
#    non-image AVs
#    contents file
# For use with classic dspace import
from variables import *
import os, shutil, urllib, json, csv, getopt, argparse

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

existingfolder = collection + exfold
for root, dirs, files in os.walk(existingfolder):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
newfolder = collection + nfold
for root, dirs, files in os.walk(newfolder):
    for f in files:
        os.unlink(os.path.join(root, f))
    for d in dirs:
        shutil.rmtree(os.path.join(root, d))
csvfile2 = open(mapfile, 'rb')
mapping = csv.DictReader(csvfile2, delimiter=':')
maparray = list(mapping)
maplen = len(maparray)
bitstreamdirectory = bitdir
import xml.etree.ElementTree as ET

fm = open(collection + "/" + environment + "mapfile.txt", "w")

tree = ET.parse(collection + xmlin)
root = tree.getroot()
from xml.dom import minidom

childno = 0
imagetotal = 0
soundvideototal = 0
manifesttotal = 0
blankaccs = 0
duplicateaccs = 0
badimagearray = []
badaccnoarray = []
dupaccnoarray = []
disappearedarray = []
# MAIN ITEM LEVEL LOOP
for child in root:
    childno = childno + 1
    import xml.etree.cElementTree as ETOut

    outroot = ETOut.Element(dcheader)
    subfolder = ''
    outfile = ''
    a = 0
    an = 0
    imagearray = []
    avnotesarray = []
    avarray = []
    itemaccno = ''
    outdata = []
    existing = ''
    duplicateacc = falsevar

    # METADATA PROCESSING
    for object in child:
        tagid = ''
        notetagid = ''
        htpos = ''
        jpgpos = ''
        iiifurl = ''
        # BUILD AV ARRAYS
        if object.tag == 'id':
            systemid = object.text
        if object.tag == 'av':
            tagid = object.get('row', '')
            if 'iiif' in object.text:
                htpos = object.text.find('http')
                # object.text =object.text.replace('http','https')
                jpgpos = object.text.find('default.jpg')
                jpgpos = jpgpos + 11
                iiifurl = object.text[htpos:jpgpos]
                imagearray.append({"row": tagid,
                                   "iiifurl": iiifurl})
            else:
                avarray.append(object.text)
            a = a + 1
        if object.tag == 'av_notes':
            notetagid = object.get('row', '')
            avnotesarray.append({"row": notetagid,
                                 'note': object.text})
            an = an + 1
            # BASIC PROCESSING BASED ON ACCESSION NO
        if object.tag == "accession_no":
            # print 'Working on item '+object.text
            j = 0
            existing = falsevar
            if 'L' in object.text:
                object.text = object.text[2:]
            if '/' in object.text:
                object.text = object.text.replace('/', '-')
            if ',' in object.text:
                object.text = object.text[:4]
            if '@' in object.text:
                object.text = object.text[:4]
            itemaccno = object.text
            f = open(collection + "/" + environment + "mapfile-prev.txt")
            for line in f.readlines():
                accno = line.split(' ')[0]
                if itemaccno == accno:
                    existing = truevar
                    fm.write(line)
                j = j + 1
            if existing == truevar:
                subfolder = existingfolder + itemaccno
            else:
                subfolder = newfolder + itemaccno
            if os.path.exists(subfolder):
                duplicateacc = truevar
                duplicateaccs = duplicateaccs + 1
                badaccnoarray.append(systemid)
                dupaccnoarray.append(itemaccno)
        # GENERATE METADATA
        if object.tag != 'av':
            m = 0
            while m < maplen:
                if maparray[m]['vernon'] == object.tag:
                    if 'dc_prod_pri_date' in object.tag:
                        object.text = object.text[7:]
                    mdschema = str(maparray[m]['dc'] + "value")
                    mdelement = str(maparray[m]['element'])
                    if maparray[m]['qualifier'] == 'noqual':
                        mdqualifier = str('')
                    else:
                        mdqualifier = str(maparray[m]['qualifier'])
                    dcvalue = ETOut.SubElement(outroot, mdschema)
                    dcvalue.set('element', mdelement)
                    dcvalue.set('qualifier', mdqualifier)
                    dcvalue.text = object.text
                m = m + 1
                # DON'T PROCEED WITH ITEM IF THERE IS NO ACCESSION NUMBER!
    print('Working on this: ' + itemaccno)
    if itemaccno == '' or duplicateacc == 'true':
        print('NO ACCESSION NUMBER- skipping')
        blankaccs = blankaccs + 1
        badaccnoarray.append(systemid)
    else:
        os.makedirs(subfolder)
        os.chmod(subfolder, 0o777)
        outfile = subfolder + "/dublin_core.xml"
        contentsfile = subfolder + "/contents"
        cfile = open(contentsfile, "w")

        # FILTER AND SORT IIIF IMAGES
        imagearraylen = len(imagearray)
        avnotearraylen = len(avnotesarray)
        i = 0
        indexedarray = []
        while i < imagearraylen:
            n = 0
            if avnotearraylen > 0:
                while n < avnotearraylen:
                    try:
                        noteno = int(avnotesarray[n]['note'])
                    except ValueError:
                        print("note not a number")
                    else:
                        if imagearray[i]['row'] == avnotesarray[n]['row'] and noteno > 0:
                            indexedarray.append({"iiifurl": imagearray[i]['iiifurl'], 'note': avnotesarray[n]['note']})
                    n = n + 1
            else:
                indexedarray.append({"iiifurl": imagearray[i]['iiifurl'],
                                     'note': '1'})

            i = i + 1
        sortedavs = []
        sortedavs = sorted(indexedarray, key=lambda dct: dct['note'])
        sortedlen = len(sortedavs)
        s = 0
        manifestarray = []
        while s < sortedlen:
            aok = 0
            if filtered == '1':
                f = open(collection + "/okimages.txt")
                dealingimage = str(sortedavs[s]['iiifurl'])
                for okimage in f.readlines():
                    if dealingimage in okimage:
                        dcvalue = ETOut.SubElement(outroot, 'dcvalue')
                        dcvalue.set('element', 'identifier')
                        dcvalue.set('qualifier', 'imageUri')
                        dcvalue.text = str(sortedavs[s]['iiifurl'])
                        iiifmanifest = dcvalue.text.replace('http', 'https')
                        iiifmanifest = iiifmanifest.replace("/iiif/", "/iiif/m/")
                        iiifmanifest = iiifmanifest.replace("full/full/0/default.jpg", "manifest")
                        print('Image passed: ' + iiifmanifest)
                        manifestarray.append(iiifmanifest)
                    aok = aok + 1
            else:
                dcvalue = ETOut.SubElement(outroot, 'dcvalue')
                dcvalue.set('element', 'identifier')
                dcvalue.set('qualifier', 'imageUri')
                dcvalue.text = sortedavs[s]['iiifurl']
                iiifmanifest = dcvalue.text.replace("iiif", "iiif/m")
                iiifmanifest = iiifmanifest.replace("full/full/0/default.jpg", "manifest")
                manifestarray.append(iiifmanifest)
            # print 'Processing image ' + sortedavs[s]['iiifurl']
            imagetotal = imagetotal + 1
            s = s + 1
        # CREATE IIIF MANIFEST
        manifestcount = len(manifestarray)
        im = 0
        canvasesarray = []
        sequencesarray = []
        labelpos = 0
        label = ''
        attribution = ''
        logo = ''
        id = ''
        type = ''
        context = ''
        related = ''
        if manifestcount > 0:
            while im < manifestcount:
                # print str(manifestarray[im])
                response = urllib.urlopen(manifestarray[im])
                try:
                    data = json.loads(response.read())
                except ValueError:
                    badimagearray.append(manifestarray[im])
                else:
                    if im == 0:
                        label = data["label"]
                        attribution = data["attribution"]
                        logo = data["logo"]
                        id = "http://" + webenv + "collections.ed.ac.uk/manifests/" + itemaccno + ".json"
                        type = "sc:Manifest"
                        context = data["@context"]
                        related = data["@id"]
                    canvasarray = []
                    canvasarray = data["sequences"][0]["canvases"][0]
                    canvasesarray.append(canvasarray)
                im = im + 1
            sequencesarray.append({"@type": "sc:Sequence",
                                   "viewingHint": "individuals",
                                   "canvases": canvasesarray})
            outdata = {
                "label": label,
                "attribution": attribution,
                "logo": logo,
                "@id": id,
                "related": related,
                "sequences": sequencesarray,
                "@type": type,
                "@context": context
            }
            manifestloc = subfolder + '/manifest.json'
            with open(manifestloc, 'w') as jsonfile:
                json.dump(outdata, jsonfile)
            cfile.write('manifest.json' + "\n")
            # print 'Processed manifest ' + manifestfolder + itemaccno + '.json'
            manifesttotal = manifesttotal + 1
            # PROCESS NON-IMAGE AVS
        avlen = len(avarray)
        ani = 0
        while ani < avlen:
            mp3pos = avarray[ani].find('mp3')
            webmpos = avarray[ani].find('webm')
            mp4pos = avarray[ani].find('mp4')
            if (mp3pos > -1) or (webmpos > -1) or (mp4pos > -1):
                for root, dirs, files in os.walk(bitstreamdirectory):
                    for _file in files:
                        if _file in avarray[ani]:
                            shutil.copy(os.path.abspath(root + '/' + _file), subfolder)
                            cfile.write(_file + "\n")
                            print("Processed sound or video " + _file)
                            soundvideototal = soundvideototal + 1
            ani = ani + 1
        cfile.close()
        rough_string = ETOut.tostring(outroot, 'utf-8')
        reparsed = minidom.parseString(rough_string)
        pretty_string = reparsed.toprettyxml(indent="\t")
        import codecs
        with codecs.open(outfile, "w", encoding='utf-8') as file:
            file.write(pretty_string)
        file.close()
f = open(collection + "/" + environment + "mapfile-prev.txt")
for accno in f.readlines():
    accno = accno.split(' ')
    found = 0
    try:
        found = os.path.isdir(existingfolder + accno[0])
    except ValueError:
        print("failure")
    # for i,j,y in os.walk(existingfolder):
    #    filename = i[21:]
    #    if accno[0] == filename:
    #        found = 'y'
    if found == 0:
        disappearedarray.append(accno[0])

f.close()
print('Processed ' + str(childno) + ' items.')
print('Processed ' + str(imagetotal) + ' IIIF images.')
print('Processed ' + str(soundvideototal) + ' non-image media.')
print('Processed ' + str(manifesttotal) + ' IIIF manifests.')
print('Skipped ' + str(blankaccs) + ' records with no accession number.')
print('Skipped ' + str(duplicateaccs) + ' duplicate accession numbers.')
for badacc in badaccnoarray:
    print("System ID to check: " + badacc)
for dupacc in dupaccnoarray:
    print("Dup image: " + dupacc)
for badimage in badimagearray:
    print("Image dead: " + badimage)
vl = open(collection + "/" + environment + "vanished.log", "w")
for disappeared in disappearedarray:
    print("Record vanished:" + disappeared)
    vl.write(disappeared)
vl.close()
fm.close()
print('Finished.')
