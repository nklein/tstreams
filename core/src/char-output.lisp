;;;; core/src/char-output.lisp

(in-package #:tstreams)

(defclass character-output-tstream
    (output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ()
  (:documentation "This class is the common base class for all TSTREAM instances which act as character output streams."))

(defun character-output-tstream-p (obj)
  "Returns whether OBJ is an instance of an CHARACTER-OUTPUT-TSTREAM class."
  (typep obj 'character-output-tstream))
