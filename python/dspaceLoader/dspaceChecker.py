#Scott Renton, May 2017
#Vernon-dSpace Loader prep for Skylight
#Reads Vernon XML file and processes
#    dublin core metadata
#    IIIF images
#    IIIF manifests
#    non-image AVs
#    contents file
#For use with classic dspace import
from variables import *
import os, shutil, urllib, json, csv
print "Hello, UNIX helpdesk"
print "OK. Jeez. What collection is it?"
collection = raw_input()
print "Right. Sigh."
print "And is that test or live?"
environment = raw_input()
if environment == 'live':
    environment = ''
    webenv = ''
else:
    webenv = environment + "."    
existingfolder = collection + exfold
newfolder = collection + nfold
disappearedarray = []
f = open(collection +"/" + environment + "mapfile.txt")
for accno in f.readlines():
    accno = accno.split('\t')
    found = 0
    try:
        found = os.path.isdir(existingfolder + accno[0])
    except ValueError, e:
        print "failure"
    #for i,j,y in os.walk(existingfolder):
    #    filename = i[21:]
    #    if accno[0] == filename:
    #        found = 'y'
    if found == 0:
        disappearedarray.append(accno[0])
for disappeared in disappearedarray:
        print disappeared + "has vanished"     
        
f.close()
print 'finished'