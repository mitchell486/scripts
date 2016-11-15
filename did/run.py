#! /usr/bin/python
from __future__ import absolute_import
import csv
import operator

## A quick check for python 2 and python 3 compatibility.

try:
   input = raw_input
except NameError:
   pass

answer = input('\n\nWould you like to print BTN or DN on non-matches?\n\nPlease enter a number: \n\n1. DN\n2. BTN\n\n> ')
print("\n")
if int(answer) == 1:
    print("All DIDs and non-DID DNs.")
else:
    btn = input('\n\nWhat is the Business Telephone Number: ')
    print("\n\nAll DIDS and the Main Number for non-DIDs.")
print("--------------------------------")


reader = csv.reader(open('did.csv', 'rU'))
did_data = []
for row in reader:
    did_data.append( (int(row[0]), int(row[1]), row[2]) )

reader = csv.reader(open('dn.txt', 'rU'))
for row in reader:
    matched = False
    dn = int(row[0])
    for k1, k2, v1 in did_data:
        if k1 <= dn <= k2:
            print(v1)
            matched = True
    if not matched:
        if int(answer) is 2:
            print(btn)
        else:
            print(dn)
