#!/usr/bin/env python
# chi.py: get children's speech from CHILDES
# Kyle Gorman <gormanky@ohsu.edu>

from __future__ import division

import gzip

from re import match
from sys import argv, stdout 
from collections import defaultdict
from csv import DictWriter, QUOTE_NONNUMERIC

from childesreader import CHILDESReader

## globals
AGE_PARSER = r'P(\d+)Y(\d+)M?(\d*)D?'
FIELDNAMES = ['Corpus', 'Source', 'Name', 'CA', 'Sex', 'Utterance']

## helpers

def rencode(my_dict, encoding='UTF-8'):
    """
    Convert string values to UTF-8 for writing out
    """
    return {k: unicode(v).encode(encoding) for (k, v) in my_dict.items()}

def role_info(cr, role):
    """
    Get a dictionary of ID: (name, months of age, sex) for
    all participants with role "role"
    """
    roledict = {}
    for p in cr.parts:
        if p['role'] == role:
            roledict[p['id']] = {'Name': p['name'], 
                                 'CA': parse_age(p.get('age')), 
                                 'Sex': 'M' if p.get('sex') == 'male' \
                                            else 'F'}
    return roledict


def parse_age(agestring):
    """
    Return age in years (a float)

    >>> parse_age('P3Y5M15D')
    3.45779
    """
    if not agestring:
        return float('nan')
    (y, m, d) = match(AGE_PARSER, agestring).groups()
    y = int(y)
    m = int(m)
    if d == '':
        d = 15.2
    else:
        d = int(d)
    return round(y + (m + d / 30.4) / 12., 5)


if __name__ == '__main__':
    # inspect arguments
    if len(argv) < 2:
        exit('USAGE: python {} [F1.xml.gz...]'.format(__file__))

    # init output
    sink = DictWriter(stdout, FIELDNAMES, quoting=QUOTE_NONNUMERIC)
    sink.writeheader()

    # parse and print
    for arg in argv[1:]:
        try:
            cr = CHILDESReader(gzip.open(arg, 'r'))
            # determine name of child
            target_IDs = role_info(cr, 'Target_Child')
            if not target_IDs:
                target_IDs = role_info(cr, 'Child')
        except KeyError as e:
            exit('Error in "{}": {}'.format(arg, str(e)))
        # read and write
        for (ID, attributes) in target_IDs.iteritems():
            my_row = attributes
            my_row['Source'] = arg
            my_row['Corpus'] = cr.corpus
            for utterance in cr.iter_utterances(ID):
                my_row['Utterance'] = utterance
                sink.writerow(rencode(my_row))
