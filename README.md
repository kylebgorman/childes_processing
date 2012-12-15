CHILDES processing code

Kyle Gorman (<gormanky@ohsu.edu>)

This repository contains code I use to process CHILDES XML transcripts.

UnicodeCSV.py
=============

This wraps `reader` and `writer` objects in the `csv` module in Python, enabling Unicode reading and writing (by default, UTF-8). This is closely based on the Python CSV module documentation online, but fixes a bug therein (`docs@python.org` has been notified).

childesparser.py
================

This file contains a class `Parser` which allows you to read CHILDES XML transcripts. Standard usage looks like:

    >>> from childesparser import Parser
    >>> sink = open('MYSINK.txt', 'w')
    >>> P = Parser(arg)
    >>> for line in P.iter_utterances('CHI'):
            print >> sink, line

By default, utterances with paralinguistic codings are ignored. For an example,
see `chi.py` below; a rewritten example can be found in `brent_cut.py`.

chi.py
======

A sample use of `childesparser.Parser` which generates the "child" side of a CHILDES XML transcription, given input files of your choice. For instance:

    python chi.py CHILDES/Brown/*/*.xml > Brown.csv

(You will need to have the Brown corpus XML files in the directory `CHILDES/Brown/`, of course.)

brent\_cut.py
=============

This file contains a heavily-modified version of `chilesparser.Parser` and code to create downsampled inputs for forced alignment on the Brent corpus. 
