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
# 
# childesparser.py: A library for parsing CHILDES XML data
# 
# This is designed to be extended as needed...

from string import whitespace
from lxml.etree import parse, XMLSyntaxError


_xsi = '{http://www.talkbank.org/ns/talkbank}'


class Parser(object):
    """
    >>> p = Parser('adam48.xml')
    >>> print p.iter_utterances('CHI').next()
    I got my motor now
    """

    def __init__(self, f):
        self.r = parse(f if hasattr(f, 'read') else open(f, 'r')).getroot()
        # data file ID
        self.corpus = self.r.attrib['Corpus']
        # demographics
        self.parts = [p.attrib for p in self.r.iter(_xsi + 'participant')]

    def iter_utterances(self, participant):
        for u in self.r.iter(_xsi + 'u'):
            if u.attrib['who'] == participant:
                # check for paralinguist coding
                try:
                    u.iter(_xsi + 'ga').next()
                    continue          # paralinguistic coding in this utterance
                except StopIteration:
                    pass              # no paralinguistic coding found
                # 
                line = ' '.join(w.text for w in u.iter(_xsi + 'w') if w.text)
                # check for blankness (how this comes about, I don't know)
                if all(char in whitespace for char in line):
                    continue
                yield line


if __name__ == '__main__':
    import doctest
    doctest.testmod()
