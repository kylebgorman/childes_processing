#!/usr/bin/env python
# mot.py: get mothers' speech from CHILDES transcripts
# Kyle Gorman <gormanky@ohsu.edu>

import gzip

from re import match
from collections import defaultdict
from sys import argv, stdout, stderr
from csv import DictWriter, QUOTE_NONNUMERIC

from childesreader import CHILDESReader

## globals
AGE_PARSER = r'P(\d+)Y(\d+)M?(\d?\d?)D?'
FIELDNAMES = ['corpus', 'utterance']

## helpers

def rencode(my_dict, encoding='UTF-8'):
    """
    Convert string values to UTF-8 for writing out
    """
    return {k: unicode(v).encode(encoding) for (k, v) in my_dict.items()}

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
        print >> stderr, 'Processing {}...'.format(arg),
        cr = CHILDESReader(gzip.open(arg, 'r'))
        # determine name of mother
        target_IDs = role_info(cr, 'Mother')
        # read and write
        for ID in target_IDs:
            my_row = {'corpus': cr.corpus}
            for utterance in cr.iter_utterances(ID):
                my_row['utterance'] = utterance
                sink.writerow(rencode(my_row))
        print >> stderr, 'done.'
