#!/usr/bin/env python

from string import uppercase
from collections import defaultdict

lemmas = defaultdict(lambda: defaultdict(set))
for line in open('lemmas.txt', 'r'):
    tags = line.rstrip().upper().split()
    sf = tags.pop(0)
    if any(char not in uppercase for char in sf):
        continue
    lemma = tags.pop(0)
    if any(t.startswith('VB') for t in tags):
        lemmas[lemma][sf].update(t for t in tags if t.startswith('VB'))

for (lemma, sfs) in lemmas.iteritems():
    print lemma,
    for (sf, tags) in sfs.iteritems():
        for tag in tags:
            print '{}/{}'.format(sf, tag),
    print
