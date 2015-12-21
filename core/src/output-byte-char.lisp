;;;; core/src/output-byte-char.lisp

(in-package #:tstreams)

(defclass binary-to-character-output-tstream
    (binary-output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as binary output streams and have a character output stream as their underlying stream."))

(defun binary-to-character-output-tstream-p (obj)
  "Return whether OBJ is an instance of BINARY-TO-CHARACTER-OUTPUT-TSTREAM."
  (typep obj 'binary-to-character-output-tstream))

(defgeneric bytes-to-character-output-stream (self bytes stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given sequence of bytes BYTES out to the underlying character output
  stream STREAM."))
