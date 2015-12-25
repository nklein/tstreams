;;;; core/src/input-char.lisp

(in-package #:tstreams)

(defclass character-input-tstream
    (input-tstream
     trivial-gray-streams:fundamental-character-input-stream)
  ((character-buffer :reader character-buffer
                     :accessor %character-buffer))
  (:documentation "This class is the common base class for all TSTREAM instances which act as character input streams."))

(defmethod initialize-instance :before ((stream character-input-tstream)
                                        &key
                                          (block-size 1)
                                          (blocks-per-buffer
                                           (if (numberp block-size)
                                               512
                                               1))
                                          &allow-other-keys)
  (check-type block-size (or (integer 1 *) (member :line)))
  (check-type blocks-per-buffer (integer 1 *))

  (flet ((fill-buffer (string)
           (characters-from-input-stream stream
                                         string
                                         (underlying-stream stream))))

    (let ((buffer (if (eql block-size :line)
                      (make-line-buffer blocks-per-buffer
                                        #'fill-buffer)
                      (make-character-buffer block-size
                                             blocks-per-buffer
                                             #'fill-buffer))))
      (setf (%character-buffer stream) buffer))))

(defun character-input-tstream-p (obj)
  "Returns whether OBJ is an instance of an CHARACTER-INPUT-TSTREAM class."
  (typep obj 'character-input-tstream))

(defgeneric characters-from-input-stream (self string stream)
  (:documentation "With the given TSTREAM instance SELF, fill the
  given STRING from the underlying input stream STREAM.  Return the
  number of characters placed into the string."))

(defmethod trivial-gray-streams:stream-read-char
    ((stream character-input-tstream))
  (get-character-from-buffer (character-buffer stream)))
