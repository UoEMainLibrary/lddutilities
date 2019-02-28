# Scott Renton, Feb 2019
# The incremental update requires
# that any new map items are written
# to a master mapfile for future updates.
# This does that.

#global variable definition, general setup

import os
import argparse

collection = ''
environment = ''

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--collection',
            action="store", dest="collection",
            help="collection loading", default="spam")
parser.add_argument('-e', '--environment',
            action="store", dest="environment",
            help="environment- test or live", default="spam")
args = parser.parse_args()

print(args)
collection= str(args.collection)
environment =str(args.environment)

print ('collection is '+ collection)
print ('environment is ' + environment)


def main():
    """
    This is the main processing loop to merge the files appearing from the last dspace import onto the master mapfile
    """
    newline_array = []
    last_run_file = collection + "/" + environment + "mapfile.txt"
    master_file = collection + "/" + environment + "mapfile-master.txt"
    new_master_file = collection + "/" + environment + "new-mapfile-master.txt"

    last_run = open(last_run_file, "r")
    for line in last_run.readlines():
        master = open(master_file, "r")
        found = False
        for master_line in master.readlines():
            if line == master_line:
                found = True
        if found == False:
            newline_array.append(line)

    new_master = open(new_master_file, "w")
    master = open(master_file, "r")
    for master_line in master.readlines():
        new_master.write(master_line)
    for new_line in newline_array:
        new_master.write(new_line)

    os.remove(master_file)
    os.rename(new_master_file, master_file)

if __name__ == '__main__':
    main()