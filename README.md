TSTREAMS library
================

`TSTREAMS` are Common Lisp Gray Streams which perform some
transformation on the data they are reading or writing before passing
the data along to an underlying stream.

Building blocks:

* BINARY-OUTPUT-STREAM => do-something(OUTPUT-STREAM)
* CHARACTER-OUTPUT-STREAM => do-something(OUTPUT-STREAM)

* BINARY-INPUT-STREAM => do-something(INPUT-STREAM)
* CHARACTER-INPUT-STREAM => do-something(INPUT-STREAM)

Class Hierarchy
---------------

1. `TSTREAM`
1. 1. `OUTPUT-TSTREAM`
1. 1. 1. `CHARACTER-OUTPUT-TSTREAM`
1. 1. 1. 1. `CHARACTER-TO-CHARACTER-OUTPUT-TSTREAM`
1. 1. 1. 2. `CHARACTER-TO-BINARY-OUTPUT-TSTREAM`
1. 1. 2. `BINARY-OUTPUT-TSTREAM`
1. 1. 2. 1. `BINARY-TO-CHARACTER-OUTPUT-TSTREAM`
1. 1. 2. 2. `BINARY-TO-BINARY-OUTPUT-TSTREAM`
1. 2. `INPUT-TSTREAM`
1. 2. 1. `CHARACTER-INPUT-TSTREAM`
1. 2. 1. 1. `CHARACTER-TO-CHARACTER-INPUT-TSTREAM`
1. 2. 1. 2. `CHARACTER-TO-BINARY-INPUT-TSTREAM`
1. 2. 2. `BINARY-INPUT-TSTREAM`
1. 2. 2. 1. `BINARY-TO-CHARACTER-INPUT-TSTREAM`
1. 2. 2. 2. `BINARY-TO-BINARY-INPUT-TSTREAM`