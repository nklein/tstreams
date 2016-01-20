;;;; core/src/input-char-char.lisp

(in-package #:tstreams)

(defclass character-to-character-input-tstream
    (character-input-tstream
     trivial-gray-streams:fundamental-character-input-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as character input streams and have a character input stream as their underlying stream."))

(defmethod initialize-instance :before
    ((self character-to-character-input-tstream)
     &key underlying-stream
       &allow-other-keys)
  (assert (character-input-stream-p underlying-stream)))

(defun character-to-character-input-tstream-p (obj)
  "Return whether OBJ is an instance of CHARACTER-TO-CHARACTER-INPUT-TSTREAM."
  (typep obj 'character-to-character-input-tstream))

(defmethod characters-from-input-stream
    ((self character-to-character-input-tstream) string stream)
  "The default method for obtaining characters as characters is
simply to copy them to the input stream."
  (read-sequence string stream))

(defun make-noop-character-to-character-input-tstream
    (underlying-input-stream
     &key close-underlying-stream-on-close
       (block-size 1)
       (blocks-per-buffer (if (numberp block-size)
                              512
                              1)))
  "Create a CHARACTER-TO-CHARACTER-INPUT-TSTREAM which takes input
characters from the underlying stream and passes them along untouched.

If CLOSE-UNDERLYING-STREAM-ON-CLOSE is non-NIL then closing the
returned stream will also close the UNDERLYING-INPUT-STREAM."
  (assert (character-input-stream-p underlying-input-stream))
  (make-instance 'character-to-character-input-tstream
                 :block-size block-size
                 :blocks-per-buffer blocks-per-buffer
                 :underlying-stream underlying-input-stream
                 :close-underlying-stream close-underlying-stream-on-close))
