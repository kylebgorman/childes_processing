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
# brent_cut.py: Cut up Brent files for forced alignment

from os import path
from glob import iglob
from lxml.etree import parse
from string import whitespace
from subprocess import Popen, check_call


# constants
_momID = 'MOT'
# In fact, there was an inconsistency in w1-1005.xml: the mother's ID was
# "EVA". I fixed this by hand. --KG
_min_duration = .2
_samplerate = '10k'
_xsi = '{http://www.talkbank.org/ns/talkbank}'


class Parser(object):

    def __init__(self, f, ai_prefix='.', ai_ext='wav',
                          ao_prefix='.', ao_ext='wav'):
        self.r = parse(f if hasattr(f, 'read') else open(f, 'r')).getroot()
        # data file ID
        self.corpus = self.r.attrib['Corpus']
        # demographics
        self.parts = [p.attrib for p in self.r.iter(_xsi + 'participant')]
        # audio naming: it's real complex
        self.name = self.r.attrib['Media']
        self.directory = self.name.split('-')[0]
        self.ai = path.join(ai_prefix, self.directory, self.name + '.' + ai_ext)
        self.ao_prefix = path.join(ao_prefix, self.directory)
        self.ao_ext = ao_ext

    def cutterances(self, participant):
        cnt = 0             # filename extension
        for (u, m) in zip(self.r.iter(_xsi + 'u'),
                          self.r.iter(_xsi + 'media')):
            if u.attrib['who'] == participant:
                ## make words
                # check for paralinguistic coding        
                try:
                    u.iter(_xsi + 'ga').next()
                    continue          # paralinguistic coding in this utterance
                except StopIteration:
                    pass              # no paralinguistic coding found
                line = ' '.join((w.text for w in u.iter(_xsi + 'w') if w.text))
                # check for blankness (how this comes about, I don't know)
                if all(char in whitespace for char in line):
                    continue
                ## cut
                # figure out start, end, duration
                start = float(m.attrib['start'])
                duration = round(float(m.attrib['end']) - start, 4)
                if duration < _min_duration:
                    continue
                sink = path.join(self.ao_prefix, '{}_{:04d}'.format(self.name, 
                                                                         cnt))
                # call SoX
                check_call(('sox', '-G', self.ai, sink + '.' + self.ao_ext,
                            'trim', str(start), str(duration),
                            'rate', '-h', _samplerate, 'dither'))
                cnt += 1
                ## write out 
                print >> open(sink + '.lab', 'w'), line.upper()


    def threaded_cutterances(self, participant):
        cnt = 0             # filename extension
        threads = []        # for SoX
        for (u, m) in zip(self.r.iter(_xsi + 'u'),
                          self.r.iter(_xsi + 'media')):
            if u.attrib['who'] == participant:
                ## make words
                # check for paralinguistic coding        
                try:
                    u.iter(_xsi + 'ga').next()
                    continue          # paralinguistic coding in this utterance
                except StopIteration:
                    pass              # no paralinguistic coding found
                line = ' '.join((w.text for w in u.iter(_xsi + 'w') if w.text))
                # check for blankness (how this comes about, I don't know)
                if all(char in whitespace for char in line):
                    continue
                ## cut
                # figure out start, end, duration
                start = float(m.attrib['start'])
                duration = round(float(m.attrib['end']) - start, 4)
                if duration < _min_duration:
                    continue
                sink = path.join(self.ao_prefix, '{}_{:04d}'.format(self.name, 
                                                                         cnt))
                # call SoX
                threads.append(Popen(('sox', '-G', 
                                      self.ai, sink + '.' + self.ao_ext,
                                      'trim', str(start), str(duration),
                                      'rate', '-h', _samplerate, 'dither')))
                cnt += 1
                ## write out 
                print >> open(sink + '.lab', 'w'), line.upper()
        # wind up SoX processing, checking for problems
        for thread in threads: 
            if thread.wait() != 0: # which is the same as the return code
                raise RuntimeError('Code {} returned'.format(thread.returncode))


if __name__ == '__main__':

    for xml in iglob('xml/*/*.xml'):
        print xml
        P = Parser(xml, 'flac', 'flac', 'clips', 'wav')
        P.cutterances(_momID)
