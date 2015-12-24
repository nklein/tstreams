;;;; core/src/input.lisp

(in-package #:tstreams)

(defclass input-tstream (tstream
                         trivial-gray-streams:fundamental-input-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM
  instances which act as input streams."))

(defmethod initialize-instance :before ((self input-tstream)
                                        &key underlying-stream
                                          &allow-other-keys)
  (assert (input-stream-p underlying-stream)))

(defun input-tstream-p (obj)
  "Returns whether OBJ is an instance of an INPUT-TSTREAM class."
  (typep obj 'input-tstream))

(defun character-input-stream-p (stream)
  "Returns whether the given stream STREAM is an input stream with an
element type of CHARACTER."
  (or (typep stream 'trivial-gray-streams:fundamental-character-input-stream)
      (and (input-stream-p stream)
           (subtypep (stream-element-type stream) 'character))))

(defun binary-input-stream-p (stream)
  "Returns whether the given stream STREAM is an input stream with an
element type of (UNSIGNED-BYTE 8)."
  (or (typep stream 'trivial-gray-streams:fundamental-binary-input-stream)
      (and (input-stream-p stream)
           (subtypep (stream-element-type stream) '(unsigned-byte 8)))))
