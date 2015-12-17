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
                                          (minimum-buffer-size 1)
                                          (preferred-buffer-size 512)
                                          &allow-other-keys)
  (check-type minimum-buffer-size (or (integer 1 *) (member :line)))
  (check-type preferred-buffer-size (integer 1 *))

  (flet ((flush-buffer (string)
           (characters-to-output-stream stream
                                        string
                                        (underlying-stream stream))))

    (let ((buffer (if (eql minimum-buffer-size :line)
                      (make-line-buffer preferred-buffer-size
                                        #'flush-buffer)
                      (make-character-buffer minimum-buffer-size
                                             preferred-buffer-size
                                             #'flush-buffer))))
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
      (flush-buffer (character-buffer stream) force))))
