#! /usr/bin/python
from __future__ import absolute_import
import csv
import operator

btn = input(int('What is the Business Telephone Number: '))


reader = csv.reader(open('did.csv', 'rU'))
did_data = []
for row in reader:
    did_data.append( (int(row[0]), int(row[1]), row[2]) )

reader = csv.reader(open('dn.txt', 'r'))
for row in reader:
    matched = False
    dn = int(row[0])
    for k1, k2, v1 in did_data:
        if k1 <= dn <= k2:
            print v1
            matched = True
    if not matched: print btn
