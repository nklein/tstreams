TODO List
---------

* Decide how to handle `FILE-POSITION` methods
* Do `BINARY-TO-BINARY-OUTPUT-TSTREAM`
* Do `BINARY-TO-BASE64-OUTPUT-TSTREAM`
* Input streams...

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
