;;;; core/src/generics.lisp

(in-package #:tstreams)

(defgeneric characters-from-input-stream (self string stream)
  (:documentation "Given the TSTREAM instance SELF, transform
  characters or bytes from the underlying input stream STREAM into
  the given string STRING.  Return the number of characters placed
  into STRING."))

(defgeneric bytes-from-input-stream (self bytes stream)
  (:documentation "Given the TSTREAM instance SELF, transform
  characters or bytes from the underlying input stream STREAM into
  the given sequence of bytes BYTES.  Return the number of bytes
  placed into BYTES."))
