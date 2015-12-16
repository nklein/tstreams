;;;; core/src/output-char-char.lisp

(in-package #:tstreams)

(defclass character-to-character-output-tstream
    (character-output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as character output streams and have a character output stream as their underlying stream."))

(defmethod initialize-instance :before
    ((self character-to-character-output-tstream)
     &key underlying-stream
       &allow-other-keys)
  (assert (character-output-stream-p underlying-stream)))

(defun character-to-character-output-tstream-p (obj)
  "Return whether OBJ is an instance of CHARACTER-TO-CHARACTER-OUTPUT-TSTREAM."
  (typep obj 'character-to-character-output-tstream))

(defgeneric characters-to-character-output-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given string STRING out to the underlying character output stream
  STREAM.")

  (:method ((self character-to-character-output-tstream) string stream)
    "The default method for converting characters to characters is
simply to copy them to the output stream."
    (write-string string stream)))

(defun make-noop-character-to-character-output-tstream
    (underlying-output-stream
     &key close-underlying-stream-on-close)
  "Create a CHARACTER-TO-CHARACTER-OUTPUT-TSTREAM which takes any
input characters given to it and passes them along untouched to the
given character output stream UNDERLYING-OUTPUT-STREAM.

If CLOSE-UNDERLYING-STREAM-ON-CLOSE is non-NIL then closing the
returned stream will also close the UNDERLYING-OUTPUT-STREAM."
  (assert (character-output-stream-p underlying-output-stream))
  (make-instance 'character-to-character-output-tstream
                 :underlying-stream underlying-output-stream
                 :close-underlying-stream close-underlying-stream-on-close))
