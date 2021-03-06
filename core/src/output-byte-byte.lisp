;;;; core/src/output-byte-byte.lisp

(in-package #:tstreams)

(defclass binary-to-binary-output-tstream
    (binary-output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as binary output streams and have a binary output stream as their underlying stream."))

(defun binary-to-binary-output-tstream-p (obj)
  "Return whether OBJ is an instance of BINARY-TO-BINARY-OUTPUT-TSTREAM."
  (typep obj 'binary-to-binary-output-tstream))

(defmethod bytes-to-output-stream
    ((self binary-to-binary-output-tstream) bytes stream)
  "The default method for converting bytes to bytes is simply to
copy them to the output stream."
  (write-sequence bytes stream))

(defun make-noop-binary-to-binary-output-tstream
    (underlying-output-stream
     &key close-underlying-stream-on-close
       (block-size 1)
       (blocks-per-buffer 512))
  "Create a BINARY-TO-BINARY-OUTPUT-TSTREAM which takes any
input bytes given to it and passes them along untouched to the
given byte output stream UNDERLYING-OUTPUT-STREAM.

If CLOSE-UNDERLYING-STREAM-ON-CLOSE is non-NIL then closing the
returned stream will also close the UNDERLYING-OUTPUT-STREAM."
  (assert (binary-output-stream-p underlying-output-stream))
  (make-instance 'binary-to-binary-output-tstream
                 :block-size block-size
                 :blocks-per-buffer blocks-per-buffer
                 :underlying-stream underlying-output-stream
                 :close-underlying-stream close-underlying-stream-on-close))
