;;;; utf8/src/output-char-byte.lisp

(in-package #:tstreams-utf8)

(defclass utf8-character-to-binary-output-tstream
    (tstreams:character-to-binary-output-tstream)
  ())

(defmethod tstreams:characters-to-output-stream
    ((self utf8-character-to-binary-output-tstream) string stream)
  (trivial-utf-8:write-utf-8-bytes string stream))

(defun make-utf8-character-to-binary-output-tstream
    (underlying-output-stream
     &key close-underlying-stream-on-close
       (block-size 1)
       (blocks-per-buffer (if (numberp block-size)
                              512
                              1)))
  "Create a UTF8-CHARACTER-TO-BINARY-OUTPUT-TSTREAM which takes any
input characters given to it and writes them to the underlying output
stream UNDERLYING-OUTPUT-STREAM as UTF-8.

If CLOSE-UNDERLYING-STREAM-ON-CLOSE is non-NIL then closing the
returned stream will also close the UNDERLYING-OUTPUT-STREAM."
  (assert (tstreams:binary-output-stream-p underlying-output-stream))
  (make-instance 'utf8-character-to-binary-output-tstream
                 :block-size block-size
                 :blocks-per-buffer blocks-per-buffer
                 :underlying-stream underlying-output-stream
                 :close-underlying-stream close-underlying-stream-on-close))
