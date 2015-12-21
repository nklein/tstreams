;;;; base64/src/output-byte-char.lisp

(in-package #:tstreams-base64)

(defclass base64-binary-to-character-output-tstream
    (tstreams:binary-to-character-output-tstream)
  ())

(defmethod tstreams:bytes-to-output-stream
    ((self base64-binary-to-character-output-tstream) bytes stream)
  (s-base64:encode-base64-bytes bytes stream))

(defun make-base64-binary-to-character-output-tstream
    (underlying-output-stream
     &key close-underlying-stream-on-close
       (preferred-buffer-size 384))
  "Create a BASE64-BINARY-TO-CHARACTER-OUTPUT-TSTREAM which takes any
input bytes given to it and writes them to the underlying output
stream UNDERLYING-OUTPUT-STREAM with base-64 encoding.

If CLOSE-UNDERLYING-STREAM-ON-CLOSE is non-NIL then closing the
returned stream will also close the UNDERLYING-OUTPUT-STREAM."
  (assert (tstreams:character-output-stream-p underlying-output-stream))
  ;; Because base64 encodes every three input bytes as four output bytes,
  ;; it behooves us to keep the block-size at three (or at least at some
  ;; multiple of three).
  (let ((blocks-per-buffer (max 1 (* 3 (floor preferred-buffer-size 3)))))
    (make-instance 'base64-binary-to-character-output-tstream
                   :block-size 3
                   :blocks-per-buffer blocks-per-buffer
                   :underlying-stream underlying-output-stream
                   :close-underlying-stream close-underlying-stream-on-close)))
