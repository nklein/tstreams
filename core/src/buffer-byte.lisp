;;;; core/src/buffer-byte.lisp

(in-package #:tstreams)

(defclass byte-buffer ()
  ((array :reader buffer-array
          :accessor %buffer-array)
   (min-size :initarg :min-size
             :reader buffer-min-size)
   (preferred-size :initarg :preferred-size
                   :reader buffer-preferred-size)
   (callback :initarg :callback
             :reader buffer-callback)))

(defun flush-byte-buffer (self &optional force)
  (declare (ignore force))
  (let ((array (buffer-array self))
        (callback (buffer-callback self)))
    (when (plusp (fill-pointer array))
      (funcall callback (coerce array 'string))
      (setf (fill-pointer array) 0))))

(defmethod initialize-instance :after ((self byte-buffer)
                                       &key &allow-other-keys)
  (setf (%buffer-array self) (make-array (buffer-preferred-size self)
                                         :element-type '(unsigned-byte 8)
                                         :fill-pointer 0
                                         :adjustable nil)))

(defun flush-byte-buffer (self &optional force)
  (let* ((array (buffer-array self))
         (callback (buffer-callback self))
         (min-size (buffer-min-size self))
         (fill (fill-pointer array))
         (floor-fill (if force
                         fill
                         (* (floor fill min-size) min-size))))
    (setf (fill-pointer array) floor-fill)
    (prog1
        (funcall callback array)
      (loop :for src :from floor-fill :below fill
         :for dst :from 0
         :do (setf (aref array dst) (aref array src)))
      (setf (fill-pointer array) (- fill floor-fill)))))

(defun add-byte-to-buffer (char self)
  (let ((array (buffer-array self)))
    (vector-push-extend char array)
    (when (= (fill-pointer array)
             (array-total-size array))
      (flush-byte-buffer self))))

(defun make-byte-buffer (block-size blocks-per-buffer callback)
  (make-instance 'byte-buffer
                 :min-size block-size
                 :preferred-size (* blocks-per-buffer block-size)
                 :callback callback))
