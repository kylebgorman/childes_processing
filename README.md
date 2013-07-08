CHILDES processing code

Kyle Gorman (<gormanky@ohsu.edu>)

This repository contains code I use to process CHILDES XML transcripts.

`parsing/childesreader.py`
==========================

This file contains a class `CHILDESReader` which allows you to read CHILDES XML transcripts. Standard usage looks like:

    >>> from childesreader import CHLIDESReader
    >>> sink = open('MYSINK.txt', 'w')
    >>> for arg in argv[1:}
    ...     cr = CHILDESReader(arg)
    ...     for utterance in cr.iter_utterances('CHI'):
    ...         print >> sink, utterance

For a longer example, see `chi.py` below.

`parsing/chi.py`
================

Generates the "child" side of CHILDES XML transcriptions. Example:

    ./chi.py XML/Brown/*/*.xml.gz > Brown.csv

(You will need to have the data in that format, of course.)

`parsing/mot.py`
================

Generates the "mother" side of CHILDES XML transcriptions, much like `chi.py`.

`parsing/brent\_cut.py`
=======================

This file contains a heavily-modified version of `childesreader.CHILDESReader` and code to create downsampled inputs for forced alignment on the Brent corpus. Out of date at the moment.
