;;;; core/src/generics.lisp

(in-package #:tstreams)

(defgeneric bytes-from-input-stream (self bytes stream)
  (:documentation "Given the TSTREAM instance SELF, transform
  characters or bytes from the underlying input stream STREAM into
  the given sequence of bytes BYTES.  Return the number of bytes
  placed into BYTES."))
