;;;; core/src/output-char.lisp

(in-package #:tstreams)

(defclass character-output-tstream
    (output-tstream
     trivial-gray-streams:fundamental-character-output-stream)
  ((character-buffer :reader character-buffer
                     :accessor %character-buffer))
  (:documentation "This class is the common base class for all TSTREAM instances which act as character output streams."))

(defmethod initialize-instance :before ((stream character-output-tstream)
                                        &key
                                          (block-size 1)
                                          (blocks-per-buffer
                                           (if (numberp block-size)
                                               512
                                               1))
                                          &allow-other-keys)
  (check-type block-size (or (integer 1 *) (member :line)))
  (check-type blocks-per-buffer (integer 1 *))

  (flet ((consume-buffer (string)
           (characters-to-output-stream stream
                                        string
                                        (underlying-stream stream))))

    (let ((buffer (if (eql block-size :line)
                      (make-line-buffer blocks-per-buffer
                                        #'consume-buffer)
                      (make-character-buffer block-size
                                             blocks-per-buffer
                                             #'consume-buffer))))
      (setf (%character-buffer stream) buffer))))

(defun character-output-tstream-p (obj)
  "Returns whether OBJ is an instance of an CHARACTER-OUTPUT-TSTREAM class."
  (typep obj 'character-output-tstream))

(defgeneric characters-to-output-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, transform the
  given string STRING out to the underlying output stream
  STREAM."))

(defmethod trivial-gray-streams:stream-write-char
    ((stream character-output-tstream) char)
  (add-character-to-buffer char (character-buffer stream)))

(defmethod cl:close :before ((stream character-output-tstream)
                             &key abort &allow-other-keys)
  (unless abort
    (let ((force t))
      (flush-char-buffer (character-buffer stream) force))))
