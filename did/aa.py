#! /usr/bin/python
from __future__ import absolute_import
import csv

# this is just an example code of what it will output the csv file as. i will need each
# individual item it outputs. and they will need to be in numbered order if possible.

reader = csv.reader(open("did.csv"))
line1 = reader.next()
line2 = reader.next()
print line2
