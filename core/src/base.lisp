;;;; core/src/base.lisp

(in-package #:tstreams)

(defclass tstream (trivial-gray-streams:fundamental-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM
  instances."))

(defun tstreamp (obj)
  "Returns whether OBJ is an instance of the TSTREAM class."
  (typep obj 'tstream))
