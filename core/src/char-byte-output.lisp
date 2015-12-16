;;;; core/src/char-byte-output.lisp

(in-package #:tstreams)

(defclass character-to-binary-output-tstream
    (character-output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as character output streams and have a binary output stream as their underlying stream."))

(defun character-to-binary-output-tstream-p (obj)
  "Return whether OBJ is an instance of CHARACTER-TO-BINARY-OUTPUT-TSTREAM."
  (typep obj 'character-to-binary-output-tstream))

(defgeneric characters-to-binary-output-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given string STRING out to the underlying binary output stream
  STREAM."))
