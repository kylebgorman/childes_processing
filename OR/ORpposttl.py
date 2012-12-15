#!/usr/bin/env python
#
# Copyright (c) 2012 Kyle Gorman
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

from os import path
from sys import argv
from collections import defaultdict
from csv import DictReader, DictWriter

from pposttl import Tagger 


if __name__ == '__main__':

    # check args
    if len(argv) != 3:
        exit('USAGE: python {0} IDSdata CHIdata'.format(__file__))

    # read info from from ORfull.csv
    OR = {}
    VBD = {}
    VBall = {}
    VBpast = {}
    rules = {}
    for row in DictReader(open('ORfull.csv', 'r')):
        VB = row['VB']
        rules[VB] = row['rule']
        OR[VB] = row['OR']
        VBall[(VB, 'VB')] = VB
        VBall[(row['VBZ'], 'VBZ')] = VB
        VBall[(row['VBG'], 'VBG')] = VB
        vbd = (row['VBD'], 'VBD') 
        VBall[vbd] = VB
        VBpast[vbd] = VB
        VBD[row['VBD']] = VB
        vbn = (row['VBN'], 'VBN')
        VBall[vbn] = VB
        VBpast[vbn] = VB

    # init tagger
    t = Tagger()

    # get frequency estimates
    VBD_f = defaultdict(int)
    VBall_f = defaultdict(int)
    VBpast_f = defaultdict(int)
    for row in DictReader(open(argv[1], 'r')):
        for (word, tag) in set(t.tag(row['utterance'])):
            word = word.upper()
            if tag.startswith('VB'):
                if (word, tag) in VBall:
                    VBall_f[VBall[(word, tag)]] += 1
                    if (word, tag) in VBpast:
                        VBpast_f[VBpast[(word, tag)]] += 1
                        if tag[-1] == 'D' and word in VBD:
                            VBD_f[VBD[word]] += 1

    # open ORfull.csv
    sink = DictWriter(open('results.csv', 'w'), fieldnames=['outcome', 
                           'child_corpus', 'age', 'VB', 'prefix.class', 
                           'functional', 'rule', 'all.f', 'past.f', 'D.f'])
    sink.writeheader()
    for row in DictReader(open(argv[2], 'r')):
        for (word, tag) in set(t.tag(row['utterance'])):
            word = word.upper()
            if tag == 'VBD':
                #if word in VBD:
                #    print 'VBD', word, VBD[word]
                if word in OR:
                    print 'OR', word, OR[word]
