;;;; core/src/generics.lisp

(in-package #:tstreams)

(defgeneric characters-from-character-input-stream (self string stream)
  (:documentation "Given the TSTREAM instance SELF, transform
  characters from the underlying character input stream STREAM into
  the given string STRING.  Return the number of characters placed
  into STRING."))

(defgeneric bytes-from-character-input-stream (self bytes stream)
  (:documentation "Given the TSTREAM instance SELF, transform
  characters from the underlying character input stream STREAM into
  the given sequence of bytes BYTES.  Return the number of bytes
  placed into BYTES."))

(defgeneric characters-from-binary-input-stream (self string stream)
  (:documentation "Given the TSTREAM instance SELF, transform bytes
  from the underlying binary input stream STREAM into the given string
  STRING.  Return the number of characters placed into STRING."))

(defgeneric bytes-from-binary-input-stream (self bytes stream)
  (:documentation "Given the TSTREAM instance SELF, transform bytes
  from the underlying binary input stream STREAM into the given
  sequence of bytes BYTES.  Return the number of bytes placed into
  BYTES."))
