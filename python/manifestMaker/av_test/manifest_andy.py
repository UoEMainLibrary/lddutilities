"""
Scott Renton, January 2019
Generate manifest for AV
"""
import csv
import json
with open('annos-78.csv', 'r') as csvfile:
    anno_reader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    anno_array = list(anno_reader)
anno_len = len(anno_array)

def control():
    '''
    All processing to read csv and generate a manifest
    '''
    canvas = "https://images-teaching.is.ed.ac.uk/luna/servlet/iiif/UoE~1~1~6~122472/canvas/c1"
    item_array = []
    anno_count = 0
    print(anno_array[anno_count])
    while anno_count < anno_len:
        if anno_array[anno_count]["id"]:
            body_array = ({
                "id":anno_array[anno_count]["id"],
                "type":anno_array[anno_count]["\ufefftype"],
                "format": anno_array[anno_count]["format"],
                "width":str(anno_array[anno_count]["width"]),
                "height":str(anno_array[anno_count]["height"]),
                "duration": str(anno_array[anno_count]["duration"])
            })
        else:
            body_array = ({
                "type":anno_array[anno_count]["\ufefftype"],
                "value":str(anno_array[anno_count]["value"]),
                "format": anno_array[anno_count]["format"]
                #"duration": str(anno_array[anno_count]["duration"])
            })

     #   body_str = str(body_array)
     #   body_str = body_str.substring(1, body_str.length-1))
        print(canvas+anno_array[anno_count]["target"])
        item_array.append({
            "id":"https://librarylabs.ed.ac.uk/iiif/andy_stewart/anno"+anno_array[anno_count]["anno_id"],
            "type":"Annotation",
            "motivation":"Painting",
            "body":body_array,

            "target":canvas+anno_array[anno_count]["target"]
        })
        anno_count += 1

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
        "width": 1200,
        "height": 1200,
        "duration": 194,
        "content": content_array
    })

    sequence_array = []
    sequence_array.append({
        "id" : "https://librarylabs.ed.ac.uk/iiif/manifest/andy_stewart/seq1",
        "type": "Sequence",
        "canvases" : canvas_array
    })

    out_data  ={
        "id" : "https://librarylabs.ed.ac.uk/iiif/manifest/andy_stewart.json",
        #IIIF 3 - no @, no sc:
        "type": "Manifest",
        "logo" : "https://images.is.ed.ac.uk/luna/images/LUNAIIIF80.png",
        "label": "AV Experiment",
        "description" : "Telling the story of Scotland Netherlands 1978",
        "sequences": sequence_array,

    }

    outfile = open('arg_78.json', 'w')
    json.dump(out_data, outfile)
    #response.close()
    print("finished")
control()
