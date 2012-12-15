#!/usr/bin/env python
# 
# Copyright (c) 2012 Kyle Gorman <gormanky@ohsu.edu>
# 
# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to 
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

from sys import argv, stdout
from csv import DictReader, DictWriter

# helpers

def ManyReader(*fids):
    for fid in fids:
        for row in DictReader(open(fid, 'r')):
            yield row


if __name__ == '__main__':

    # check args
    if len(argv) < 2:
        exit('USAGE: python {0} [args]'.format(__file__))

    # get irregular table
    targets = {}
    source = DictReader(open('ORfull.csv', 'r'))
    for row in source:
        targets[row['OR']]  = (0, row['VB'], row['rule'])
        targets[row['VBD']] = (1, row['VB'], row['rule'])
        targets[row['VBN']] = (1, row['VB'], row['rule'])

    # init sink
    sink = DictWriter(stdout, fieldnames=['correct', 'stem', 'rule',
                              # FIXME     #'word.freq', 'verb.freq',
                                          'child', 'age'])
    sink.writeheader()

    for row in ManyReader(*argv[1:]):
        # check age
        age = float(row['age']) # in case it's NAN
        if age >= 60:
            continue
        # tag
        for word in set(row['utterance'].upper().split()):
            if word in targets:
                (correct, stem, rule) = targets[word]
                sink.writerow({'correct': correct, 'stem': stem, 
                               'rule': rule, 'age': age,
                               'child': row['corpus'] + '_' + row['name']})
