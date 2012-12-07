#!/usr/bin/env python
# 
# ids.py: get speech by mothers
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
    Get a set of IDs for participants with role "role"
    """
    roledict = set()
    for p in P.parts:
        if p['role'] == role:
            roledict.add(p['id'])
    return roledict


if __name__ == '__main__':
    
    if len(argv) < 2:
        exit('USAGE: python {0} [args]'.format(__file__))

    sink = UnicodeWriter(stdout, quoting=QUOTE_NONNUMERIC)
    sink.writerow(('filename', 'corpus', 'utterance'))

    for arg in argv[1:]:
        try:
            P = Parser(arg)
        except XMLSyntaxError:
            print >> stderr, 'Failed to read XML file from {0}'.format(arg)
            continue
        print >> stderr, arg
        # figure out name of child
        target_ids = role_info(P, 'Mother')
        for tid in target_ids:
            for line in P.iter_utterances(tid):
                sink.writerow((arg, P.corpus, line))
