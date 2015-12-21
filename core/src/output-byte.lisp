;;;; core/src/output-byte.lisp

(in-package #:tstreams)

(defclass binary-output-tstream
    (output-tstream
     trivial-gray-streams:fundamental-binary-output-stream)
  ((byte-buffer :reader byte-buffer
                :accessor %byte-buffer))
  (:documentation "This class is the common base class for all TSTREAM instances which act as binary output streams."))

(defmethod initialize-instance :before ((stream binary-output-tstream)
                                        &key
                                          (block-size 1)
                                          (blocks-per-buffer 512)
                                          &allow-other-keys)
  (check-type block-size (integer 1 *))
  (check-type blocks-per-buffer (integer 1 *))

  (flet ((consume-buffer (bytes)
           (bytes-to-output-stream stream
                                   bytes
                                   (underlying-stream stream))))

    (let ((buffer (make-byte-buffer block-size
                                    blocks-per-buffer
                                    #'consume-buffer)))
      (setf (%byte-buffer stream) buffer))))

(defun binary-output-tstream-p (obj)
  "Return whether OBJ is an instance of BINARY-OUTPUT-TSTREAM"
  (typep obj 'binary-output-tstream))

(defgeneric bytes-to-output-stream (self bytes stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given sequence of bytes BYTES out to the underlying output
  stream STREAM."))

(defmethod trivial-gray-streams:stream-write-byte
    ((stream binary-output-tstream) byte)
  (add-byte-to-buffer byte (byte-buffer stream)))

(defmethod cl:close :before ((stream binary-output-tstream)
                             &key abort &allow-other-keys)
  (unless abort
    (let ((force t))
      (flush-byte-buffer (byte-buffer stream) force))))
