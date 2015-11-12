#! /usr/bin/python
from __future__ import absolute_import
import csv
import operator

## You will need 2 files for comparing this information,
## email-exchange.csv will be emails provided from exchange admins
## full-export.csv is the cleaned up export from UCXN


reader = csv.reader(open('email-exchange.csv', 'rU'))
email_data = set()
for row in reader:
    email_data.add( row[0] )


final = open('full-export.csv', 'rU')
reader = csv.reader(final)
headers = reader.next()
final_data = []
for row in reader:
    final_data.append( row )

new_exchange_name = raw_input('What is the EXACT name of your new Unified Messasging Exchange Connection Name? \n')

final_delete = open('final-delete.csv', 'w+')
writer = csv.writer(final_delete)
writer.writerow(headers)
for row in final_data:
    email = str(row[3])
    exchange = row[1]
    rowlist = list(row)
    rowlist[2] = ''
    row = tuple(rowlist)
    if email in email_data:
        if exchange == new_exchange_name:
            continue
        else:
            writer.writerow(row)
final_delete.close()

final_create = open('final-create.csv', 'w+')
writer = csv.writer(final_create)
writer.writerow(headers)
for row in final_data:
    email = str(row[3])
    exchange = row[1]
    rowlist = list(row)
    rowlist[1] = new_exchange_name
    rowlist[2] = ''
    row = tuple(rowlist)
    if email in email_data:
        if exchange == new_exchange_name:
            continue
        else:
            writer.writerow(row)
final_create.close()
