#! /usr/bin/python
from __future__ import absolute_import
import csv
import operator

# x = input('Enter the extension here: ')
# btn = input('What is the Business Telephone Number: ')

d = open('dn.txt', 'r')
reader = csv.reader(d)
for eachline in reader:
    dn = int(eachline[0])

with open('did.csv', 'rU') as c:
    reader = csv.reader(c)
    for row in reader:
        k1 = int(row[0])
        k2 = int(row[1])
        v1 = row[2]
        if k1 <= dn <= k2:
            print v1


## NOTE: The CSV I'm importing is in this format... I have 9 lines for now. More in the future.
## I need to be able to make k2 move to the second line in an "if" loop...
## k1 <= x <= k2
## print v1
## and I need that to change with each line of the csv
## basically it should say "is 7806 in between k1 and k2 for line1? No? Move to line2... and repeat.

## 0174,0180,812555XXXX
## 0182,0194,888555XXXX
