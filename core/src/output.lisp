;;;; core/src/output.lisp

(in-package #:tstreams)

(defclass output-tstream (tstream
                          trivial-gray-streams:fundamental-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM
  instances which act as output streams."))

(defun output-tstream-p (obj)
  "Returns whether OBJ is an instance of an OUTPUT-TSTREAM class."
  (typep obj 'output-tstream))
