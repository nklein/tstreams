;;;; core/src/generics.lisp

(in-package #:tstreams)

(defgeneric characters-to-character-output-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given string STRING out to the underlying character output stream
  STREAM."))

(defgeneric bytes-to-character-output-stream (self bytes stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given sequence of bytes BYTES out to the underlying character output
  stream STREAM."))

(defgeneric characters-to-binary-output-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given string STRING out to the underlying binary output stream
  STREAM."))

(defgeneric bytes-to-binary-output-stream (self bytes stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given sequence of bytes BYTES out to the underlying binary output
  stream STREAM."))

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
