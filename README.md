TSTREAMS library
================

`TSTREAMS` are Common Lisp Gray Streams which perform some
transformation on the data they are reading or writing before passing
the data along to an underlying stream.

Building blocks:

* BINARY-OUTPUT-TSTREAM => do-something(OUTPUT-STREAM)
* CHARACTER-OUTPUT-TSTREAM => do-something(OUTPUT-STREAM)

* BINARY-INPUT-TSTREAM <= do-something(INPUT-STREAM)
* CHARACTER-INPUT-TSTREAM <= do-something(INPUT-STREAM)

Example: CHARACTERS => UTF-8 => BASE-64 => FILE
-----------------------------------------------

Suppose you need to write Unicode characters to a file which, because
of the way that it will be delivered, can only contain 7-bit clean
ASCII characters.  You might do something like this:

    (with-open-file (out-stream out-filename :direction :output)
      (with-open-stream (base64-stream
                         (make-base64-binary-to-character-output-tstream
                            out-stream))
        (with-open-stream (utf8-stream
                           (make-utf8-character-to-binary-output-tstream
                              base64-stream))
          (write-string "π ⠏⠊, θ ⠮⠞⠁" utf8-stream)
          (write-more-stuff-to-stream utf8-stream))))

Then on the reading side:

    (with-open-file (in-stream in-filename)
      (with-open-stream (base64-stream
                         (make-base64-character-to-binary-input-tstream
                            in-stream))
        (with-open-stream (utf8-stream
                           (make-utf8-binary-to-character-input-tstream
                              base64-stream))
          (read-stuff-from-stream utf8-stream))))

XXX: Should add a `WITH-OPEN-STREAMS*` macro to streamline the above:

    (with-open-streams*
        ((out-stream (open out-filename :direction :output))
         (base64-stream (make-base64-binary-to-character-output-tstream
                           out-stream))
         (utf8-stream (make-utf8-character-to-binary-output-tstream
                         base64-stream)))
      (write-string "π ⠏⠊, θ ⠮⠞⠁" utf8-stream)
      (write-more-stuff-to-stream utf8-stream))

Class Hierarchy
---------------

1. `TSTREAM`
  1. `OUTPUT-TSTREAM`
    1. `CHARACTER-OUTPUT-TSTREAM`
      1. `CHARACTER-TO-CHARACTER-OUTPUT-TSTREAM`
      2. `CHARACTER-TO-BINARY-OUTPUT-TSTREAM`
    2. `BINARY-OUTPUT-TSTREAM`
      1. `BINARY-TO-CHARACTER-OUTPUT-TSTREAM`
      2. `BINARY-TO-BINARY-OUTPUT-TSTREAM`
  2. `INPUT-TSTREAM`
    1. `CHARACTER-INPUT-TSTREAM`
      1. `CHARACTER-TO-CHARACTER-INPUT-TSTREAM`
      2. `BINARY-TO-CHARACTER-INPUT-TSTREAM`
    2. `BINARY-INPUT-TSTREAM`
      1. `CHARACTER-TO-BINARY-INPUT-TSTREAM`
      2. `BINARY-TO-BINARY-INPUT-TSTREAM`
