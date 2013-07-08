#!/usr/bin/env python
#
# Copyright (c) 2012-2013 Kyle Gorman <gormanky@ohsu.edu>
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
# childesreader.py: Read CHILDES XML data, fast.


from re import match
from lxml.etree import parse, XMLSyntaxError


## globals

# tag names (FIXME: probably some way to do this with namespaces)
XSI = '{http://www.talkbank.org/ns/talkbank}'
XSIa = XSI + 'a'
XSIgrammar = XSI + 'g'
XSIparticipant = XSI + 'participant'
XSIutterance = XSI + 'u'
XSIword = XSI + 'w'

# a blank line...
BLANK = r'^\s*$'


class CHILDESReader(object):
    """
    Object representing a single CHILDES transcript

    >>> import gzip
    >>> p = CHILDESReader(gzip.open('adam48.xml.gz', 'r'))

    Traverse with self.iter_utterances(your_ID), like so:

    >>> utterances = list(p.iter_utterances('CHI'))
    >>> print utterances[0]
    I got my motor now

    Confirm presence of overregularization ("maked"):

    >>> for utterance in utterances:
    ...     if 'turtle' in utterance:
    ...         print utterance
    it's a turtle right
    we maked a turtle didn't we today
    that's a turtle
    is dis about turtles
    is dis de turtle one
    that's a pretty turtle
    """

    def __init__(self, f):
        # XML object
        self.f = parse(f).getroot()
        # corpus ID
        self.corpus = self.f.attrib['Corpus']
        # participant information
        self.parts = [p.attrib for p in self.f.iter(XSIparticipant)]

    @staticmethod
    def words(utterance):
        """
        Get actual words out from the <u> Element representing an utterance
        """
        for word in utterance:
            if word.tag == XSIword:
                # transcriptions in the utterance
                if word.get('formType') == 'UNIBET':
                    uwords = word.iter(XSIword)
                    phon = uwords.next().text
                    for uword in uwords:
                        yield uword.text
                    yield u'[{}]'.format(phon)
                # normal case
                else:
                    yield word.text
            # child's word is wrapped in <g></g> tag
            elif word.tag == XSIgrammar:
                yield word[0].text

    def iter_utterances(self, ID):
        for utterance in self.f:
            # inspect tag
            if utterance.tag != XSIutterance:
                continue
            # ignore wrong participants
            if utterance.attrib['who'] != ID:
                continue
            # get words
            L = ' '.join(w for w in CHILDESReader.words(utterance) if
                         w is not None)
            if not match(BLANK, L):
                yield L


if __name__ == '__main__':
    import doctest
    doctest.testmod()
