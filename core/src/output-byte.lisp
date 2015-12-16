;;;; core/src/output-byte.lisp

(in-package #:tstreams)

(defclass binary-output-tstream
    (output-tstream
     trivial-gray-streams:fundamental-binary-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as binary output streams."))

(defun binary-output-tstream-p (obj)
  "Return whether OBJ is an instance of BINARY-OUTPUT-TSTREAM"
  (typep obj 'binary-output-tstream))
