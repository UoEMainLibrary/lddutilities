# Scott Renton, May 2017
# Vernon-dSpace Loader prep for Skylight
# Reads Vernon XML file and processes
#    dublin core metadata
#    IIIF images
#    IIIF manifests
#    non-image AVs
#    contents file
# For use with classic dspace import

import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-c', '--collection',
            action="store", dest="collection",
            help="collection loading", default="mimed")

args = parser.parse_args()

print(args)
collection= str(args.collection)

print ('collection is '+ collection)

if collection == 'art':
    background_img = 'UoEart~1~1~74613~168756'
    end_notes = ' in the Art Collection '
elif collection == 'mimed':
    background_img = 'UoEgal~4~4~168664~177233'
    end_notes = ' at St Cecilias Hall '
else:
    background_img = 'UoEgal~4~4~168664~177233'
    end_notes = ' at St Cecilias Hall '


def append_item(body_array, canvas, ts, tf, annocount,x,y):
    '''
    Add body into array
    :param body_array:
    :return:
    '''
    item = {
        "id":"https://librarylabs.ed.ac.uk/iiif/andy_stewart/anno"+str(annocount),
        "type":"Annotation",
        "motivation":"Painting",
        "body":body_array,
        "target": canvas + "#xywh="+str(x) +"," + str(y) + "," +str(body_array["width"]) + ","+str(body_array["height"])+"&t="+str(ts) + "," +str(tf)
    }
    return item

# MAIN ITEM LEVEL LOOP
def control():
    '''
    All processing to read csv and generate a manifest
    '''
    import os, shutil, urllib, json, csv, getopt, argparse
    import xml.etree.ElementTree as ET
    from requests import get
    from io import BytesIO
    from PIL import Image
    from mutagen.mp3 import MP3
    from mutagen.mp4 import MP4
    import math

    existingfolder = collection + "/manifests"
    for root, dirs, files in os.walk(existingfolder):
        for f in files:
            os.unlink(os.path.join(root, f))

    xmlin = collection + '/dspace.xml'
    tree = ET.parse(xmlin)
    root = tree.getroot()
    from xml.dom import minidom

    childno = 0

    for child in root:
        childno = childno + 1
        import xml.etree.cElementTree as ETOut
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
        doing = 0
        gotcreator = 0
        gottitle = 0
        gotdesc = 0
        gotdate = 0
        desc = ''
        title = ''
        creator = ''
        date = ''
        # METADATA PROCESSING
        for object in child:
            tagid = ''
            notetagid = ''
            htpos = ''
            jpgpos = ''
            iiifurl = ''

            # BUILD AV ARRAYS
            if object.tag == 'av':
                tagid = object.get('row', '')
                if 'iiif' in object.text:
                    htpos = object.text.find('http')
                    # object.text =object.text.replace('http','https')
                    jpgpos = object.text.find('default.jpg')
                    jpgpos = jpgpos + 11
                    iiifurl = object.text[htpos:jpgpos]
                    avarray.append(object.text)
                else:
                    avarray.append(object.text)
                    doing = 1
                a = a + 1
            if object.tag == 'av_notes':
                notetagid = object.get('row', '')
                avnotesarray.append({"row": notetagid,
                                     'note': object.text})
                an = an + 1
                # BASIC PROCESSING BASED ON ACCESSION NO
            if object.tag == "name":
                title = object.text
                gottitle = 1
            if object.tag == "prod_pri_person":
                creator = object.text
                gotcreator = 1
            if object.tag == "prod_pri_date":
                date = object.text
                gotdate = 1
            if object.tag == "user_text_1":
                desc = object.text
                gotdesc = 1
            if object.tag == "accession_no":
                # print 'Working on item '+object.text
                j = 0
                if 'L' in object.text:
                    object.text = object.text[2:]
                if '/' in object.text:
                    object.text = object.text.replace('/', '-')
                if ',' in object.text:
                    object.text = object.text[:4]
                if '@' in object.text:
                    object.text = object.text[:4]
                itemaccno = object.text


            # FILTER AND SORT IIIF IMAGES
            imagearraylen = len(imagearray)
            avnotearraylen = len(avnotesarray)

        if doing == 1:
            if gotdesc == 0:
                desc = '(Awaiting description)'
            if gotdate == 0:
                date = '(Awaiting date)'
            if gotcreator == 0:
                creator = "(Awaiting creator)"
            if gottitle == 0:
                title = "(Awaiting title)"
            avlen = len(avarray)

            canvas = "https://images-teaching.is.ed.ac.uk/luna/servlet/iiif/UoEgal~4~4~168664~177233/canvas/c1"
            audio_file = ''
            video_file = ''

            s = 0
            sduration = 0
            audiocount = 0
            while s < avlen and audiocount <= 1:
                if 'mp3' in avarray[s]:
                    sample_fail = 0
                    print("WORKING WITH" + str(avarray[s]))

                    mp3pos = avarray[s].find(".mp3")
                    usefile = "media/" + avarray[s][mp3pos -8: mp3pos + 4]

                    print(usefile)
                    try:
                        audio = MP3(usefile)
                        sduration=audio.info.length
                    except:
                        sample_fail = 1

                    if sample_fail == 0:
                        audio_file = usefile

                    audiocount +=1
                s += 1

            s = 0
            videocount =0
            vduration = 0
            while s < avlen and videocount <= 1:
                if 'mp4' in avarray[s]:
                    sample_fail =0
                    print("WORKING WITH" + str(avarray[s]))

                    mp4pos = avarray[s].find(".mp4")
                    usefile = "media/" + avarray[s][mp4pos -8: mp4pos + 4]

                    print(usefile)
                    try:
                        video = MP4(usefile)
                        vduration=video.info.length
                    except:
                        sample_fail = 1
                    print("SAMPLE_FAIL " + str(sample_fail))
                    if sample_fail == 0:
                        video_file = usefile
                    videocount +=1
                s += 1
            av_total = audiocount + videocount
            if av_total > 0:
                item_array = []

                image_no = 0

                annocount = 0

                duration =sduration + vduration
                duration_rounded = math.ceil(duration)

                body_array = ({
                    "id":"https://images.is.ed.ac.uk/luna/servlet/iiif/"+background_img+"/full/full/0/default.jpg",
                    "type":"Image",
                    "format": "image/jpeg",
                    "width": 1600,
                    "height":1000
                })

                item = append_item(body_array, canvas, 0, duration_rounded, annocount,0,0)
                item_array.append(item)

                annocount+=1

                if audio_file:
                    body_array = ({
                        "id":"https://librarylabs.ed.ac.uk/iiif/" +  audio_file,
                        "type":"Audio",
                        "format": "audio/mp3",
                        "width":200,
                        "height": 200,
                        "duration": sduration
                        })

                    item = append_item(body_array, canvas, 0, sduration, annocount,100,100)
                    item_array.append(item)

                annocount+=1
                print(vduration)
                if video_file:
                    body_array_w = ({
                            "id":"https://librarylabs.ed.ac.uk/iiif/media/white.jpg",
                            "type":"Image",
                            "format": "image/jpeg",
                            "width":810,
                            "height":460,
                            "duration": vduration
                        })

                    item = append_item(body_array_w, canvas, sduration, sduration + vduration,  annocount,20,20)
                    item_array.append(item)

                    body_array = ({
                        "id":"https://librarylabs.ed.ac.uk/iiif/" + video_file,
                        "type":"Video",
                        "format": "video/mp4" ,
                        "width":800,
                        "height":450,
                        "duration": vduration
                     })

                    item = append_item(body_array, canvas, sduration, sduration + vduration, annocount,25,25)
                    item_array.append(item)


                s = 0
                imagecount = 0

                while s < avlen:
                    if 'iiif' in avarray[s]:
                        imagecount  += 1
                    s+=1
                if imagecount > 1:
                    target_time = round(duration/imagecount,2)
                    target_finish = 0
                else:
                    target_time = duration
                    target_finish = 0

                s = 0
                annocount+=1
                max_height = 410
                while s < avlen:
                    if 'iiif' in avarray[s]:
                        if image_no == 0:
                           image_target_finish = 0

                        try:
                            file = avarray[s].split("; ")
                        except Exception:
                            file = avarray[s]

                        print(file)

                        try:
                            filename = file[1].split(" (")
                        except Exception:
                            filename = file[0].split(" (")

                        print(filename)
                        image_raw = get(str(filename[0]))
                        image = Image.open(BytesIO(image_raw.content))
                        width, height = image.size
                        if width > height:
                            width_new = 700
                            divisor = width/700
                            height_new = height/divisor
                            x_pos  = 880
                        else:
                            height_new = 700
                            divisor = height/700
                            width_new = width/divisor
                            x_pos = (1600 - width_new) - 20

                        if height_new > max_height:
                            max_height = height_new

                        body_array_w = ({
                            "id":"https://librarylabs.ed.ac.uk/iiif/media/white.jpg",
                            "type":"Image",
                            "format": "image/jpeg",
                            "width":width_new + 10,
                            "height":height_new + 10,
                            "duration": target_time
                        })

                        image_target_start = image_target_finish
                        image_target_finish = image_target_start + target_time
                        target_start =  image_target_start
                        target_finish = image_target_start + target_time
                        image_no += 1
                        item = append_item(body_array_w, canvas, target_start, target_finish, annocount,x_pos,20)
                        item_array.append(item)

                        body_array_i = ({
                            "id":filename[0],
                            "type":"Image",
                            "format": "image/jpeg",
                            "width":width_new,
                            "height":height_new,
                            "duration": target_time
                        })

                        image_no += 1
                        item = append_item(body_array_i, canvas, target_start, target_finish, annocount,x_pos+5,25)
                        item_array.append(item)
                        annocount+=1
                    s+=1

                body_array = ({
                    "type":"TextualBody",
                    "format": "text/plain",
                    "value": str(itemaccno) + ":" + title + " " + creator + " " + date,
                    "width":1400,
                    "height": 200
                })


                item = append_item(body_array, canvas, 0, duration/2, annocount,100,max_height + 50)
                item_array.append(item)

                annocount+= 1

                body_array = ({
                    "type":"TextualBody",
                    "format": "text/plain",
                    "value": desc,
                    "width":1400,
                    "height": 200
                })

                item = append_item(body_array, canvas, duration/2, duration-3, annocount,100,max_height + 50)
                item_array.append(item)

                annocount+=1


                body_array = ({
                    "type":"TextualBody",
                    "format": "text/plain",
                    "value": "See item " + str(itemaccno)  + end_notes + " at The University of Edinburgh",
                    "width":1600,
                    "height": 100
                })

                item = append_item(body_array, canvas, duration, duration_rounded, annocount,350,300)
                item_array.append(item)

                annocount+=1

                body_array = ({
                    "type":"Image",
                    "format": "image/jpeg",
                    "id": "http://www.hkcci.com.hk/wp-content/uploads/2017/03/UoE_Centred-Logo_white_v1_160215.png",
                    "width":617,
                    "height": 495
                })

                item = append_item(body_array, canvas, duration-3, duration_rounded, annocount,500,500)
                item_array.append(item)

                content_array = []
                content_array.append({
                    "id": "https://tomcrane.github.io/fire/annos/page",
                    "type": "AnnotationPage",
                    "items": item_array
                })

                canvas_array = []
                canvas_array.append({
                    "id": canvas,
                    "type": "Canvas",
                    "width": 1600,
                    "height": 1000,
                    "duration": duration_rounded,
                    "content": content_array
                })

                sequence_array = []
                sequence_array.append({
                    "id" : "https://librarylabs.ed.ac.uk/iiif/manifest/andy_stewart/seq1",
                    "type": "Sequence",
                    "canvases" : canvas_array
                })

                out_data  ={
                    "id" : "https://librarylabs.ed.ac.uk/iiif/manifest/" + itemaccno + ".json",
                    #IIIF 3 - no @, no sc:
                    "type": "Manifest",
                    "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
                    "label": "AV Experiment",
                    "description" : "Testing image, audio and video through IIIF Presentation 3 manifest",
                    "sequences": sequence_array,

                }

                outfile = open(collection +'/manifests/' + itemaccno + '.json', 'w')
                json.dump(out_data, outfile)

control()
print('Finished.')
