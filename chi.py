#!/usr/bin/env python
# 
# chi.py: get children's speech in CHILDES
# 
# Kyle Gorman <gormanky@ohsu.edu>

from re import match
from csv import QUOTE_NONNUMERIC
from collections import defaultdict
from sys import argv, stdout, stderr
from lxml.etree import XMLSyntaxError

from childesparser import Parser
from UnicodeCSV import UnicodeWriter

# helpers


def role_info(P, role):
    """
    Get a dictionary of ID: (name, age as integer of months, sex) for 
    all participants with role "role"
    """
    roledict = {}
    for p in P.parts:
        if p['role'] == role:
            roledict[p['id']] = (p['name'], parse_age(p.get('age')), 
                                 p.get('sex'))
    return roledict


def parse_age(agestring):
    """
    Return age in months (an integer)
    """
    if not agestring:
        return float('nan')
    m = match(r'P(\d+)Y(\d+)M?(\d?\d?)D?', agestring)
    return int(m.group(1)) * 12 + int(m.group(2))


if __name__ == '__main__':
    
    if len(argv) < 2:
        exit('USAGE: python {0} [args]'.format(__file__))

    sink = UnicodeWriter(stdout, quoting=QUOTE_NONNUMERIC)
    sink.writerow(('filename', 'corpus', 'name', 'age', 'sex', 'utterance'))

    for arg in argv[1:]:
        # init
        try:
            P = Parser(arg)
        except XMLSyntaxError:
            print >> stderr, 'Failed to read XML file from {0}'.format(arg)
            continue
        print >> stderr, arg
        # figure out name of child
        target_ids = role_info(P, 'Target_Child')
        if not target_ids:
            target_ids = role_info(P, 'Child')
        # write
        for (tid, (name, age, sex)) in target_ids.iteritems():
            for line in P.iter_utterances(tid):
                sink.writerow((arg, P.corpus, name, age, sex, line))
