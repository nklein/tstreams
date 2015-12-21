;;;; core/src/base.lisp

(in-package #:tstreams)

(defclass tstream (trivial-gray-streams:fundamental-stream)
  ((underlying-stream :initarg :underlying-stream
                      :reader underlying-stream)
   (close-underlying-stream :initarg :close-underlying-stream
                            :reader close-underlying-stream-p))
  (:default-initargs
   :underlying-stream (error "Must provide :UNDERLYING-STREAM.")
   :close-underlying-stream nil)
  (:documentation "This class is the common base class for all TSTREAM
  instances."))

(defun tstreamp (obj)
  "Returns whether OBJ is an instance of the TSTREAM class."
  (typep obj 'tstream))

(defmethod cl:close :after ((self tstream) &key &allow-other-keys)
  (when (close-underlying-stream-p self)
    (cl:close (underlying-stream self))))
