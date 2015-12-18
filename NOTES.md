TODO List
---------

* Decide how to handle `FILE-POSITION` methods
* Do `CHARACTER-TO-UTF8-OUTPUT-STREAM`
* Do `BINARY-TO-BINARY-OUTPUT-STREAM`
* Do `BINARY-TO-BASE64-OUTPUT-STREAM`
* Input streams...

TSTREAMS-UTF8
-------------

Should be able to:

    (defclass character-to-utf8-output-stream
        (character-to-binary-output-tstream)
      ()
      (:documentation "...XXX..."))

    (defmethod characters-to-binary-output-stream
        ((self character-to-utf8-output-stream) string stream)
      (trivial-utf-8:write-utf-8-bytes string stream))

TSTREAMS-BASE64
---------------

Should be able to:

    (defclass binary-to-base64-output-stream
        (binary-to-character-output-tstream)
      ()
      (:documentation "...XXX..."))

    (defmethod bytes-to-character-output-stream
        ((self binary-to-base64-output-stream) bytes stream)
      (s-base64:encode-base64-bytes bytes stream))
