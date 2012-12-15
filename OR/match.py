#!/usr/bin/env python

from csv import DictReader, DictWriter

if __name__ == '__main__':

    # get morph information
    morph = {}
    for row in DictReader(open('english_1985.csv', 'r')):
        word = row['word'].upper()
        morph[word] = '{} {}'.format(row['stemchange.noD'], row['suffix'])

    # match with surface forms
    source = DictReader(open('OR.csv', 'r'))
    sink = DictWriter(open('ORfull.csv', 'w'), fieldnames = \
                                        source.fieldnames + ['rule'])
    sink.writeheader()
    for row in source:
        row['rule'] = morph[row['VB']]
        sink.writerow(row)
