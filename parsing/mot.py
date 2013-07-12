#!/usr/bin/env python
# mot.py: get mothers' speech from CHILDES transcripts
# Kyle Gorman <gormanky@ohsu.edu>

import gzip

from os import path
from re import match
from sys import argv, stdout
from collections import defaultdict
from csv import DictWriter, QUOTE_NONNUMERIC

from childesreader import CHILDESReader

## globals
FIELDNAMES = ['Corpus', 'Utterance']

## helpers

def mac(name):
    """
    Guh.
    """
    if name == 'Macwhinney':
        return 'MacWhinney'
    return name

def rencode(my_dict, encoding='UTF-8'):
    """
    Convert string values to UTF-8 for writing out
    """
    return {k: unicode(v).encode(encoding) if hasattr(v, 'encode') else v
                                           for (k, v) in my_dict.items()}

def role_info(cr, role):
    """
    Get a dictionary of ID: name for all participants with role "role"
    """
    roledict = set()
    for p in cr.parts:
        if p['role'] == role:
            roledict.add(p['id'])
    return roledict


if __name__ == '__main__':

    # inspect arguments
    if len(argv) < 2:
        exit('USAGE: python {} [F1.xml.gz...]'.format(__file__))

    # init output
    sink = DictWriter(stdout, FIELDNAMES, quoting=QUOTE_NONNUMERIC)
    sink.writeheader()

    # parse and print
    for arg in argv[1:]:
        cr = CHILDESReader(gzip.open(arg, 'r'))
        # determine name of mother
        target_IDs = role_info(cr, 'Mother')
        # read and write
        for ID in target_IDs:
            my_row = {'Corpus': mac(cr.corpus.title())}
            for utterance in cr.iter_utterances(ID):
                my_row['Utterance'] = utterance
                sink.writerow(rencode(my_row))
