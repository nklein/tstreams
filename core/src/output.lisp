;;;; core/src/output.lisp

(in-package #:tstreams)

(defclass output-tstream (tstream
                          trivial-gray-streams:fundamental-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM
  instances which act as output streams."))

(defmethod initialize-instance :before ((self output-tstream)
                                        &key underlying-stream
                                          &allow-other-keys)
  (assert (output-stream-p underlying-stream)))

(defun output-tstream-p (obj)
  "Returns whether OBJ is an instance of an OUTPUT-TSTREAM class."
  (typep obj 'output-tstream))

(defun character-output-stream-p (stream)
  "Returns whether the given stream STREAM is an output stream with an
element type of CHARACTER."
  (or (typep stream 'trivial-gray-streams:fundamental-character-output-stream)
      (and (output-stream-p stream)
           (subtypep (stream-element-type stream) 'character))))

(defun binary-output-stream-p (stream)
  "Returns whether the given stream STREAM is an output stream with an
element type of (UNSIGNED-BYTE 8)."
  (or (typep stream 'trivial-gray-streams:fundamental-binary-output-stream)
      (and (output-stream-p stream)
           (subtypep (stream-element-type stream) '(unsigned-byte 8)))))
