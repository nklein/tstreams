;;;; core/src/buffer-char.lisp

(in-package #:tstreams)

(defgeneric add-character-to-buffer (char buffer))
(defgeneric get-character-from-buffer (buffer))
(defgeneric flush-char-buffer (buffer &optional force))

(defclass char-buffer ()
  ((array :reader buffer-array
          :accessor %buffer-array)
   (preferred-size :initarg :preferred-size
                   :reader buffer-preferred-size)
   (read-position :accessor read-position
                  :initform 0)
   (callback :initarg :callback
             :reader buffer-callback)))

(defmethod flush-char-buffer ((self char-buffer) &optional force)
  (declare (ignore force))
  (let ((array (buffer-array self))
        (callback (buffer-callback self)))
    (when (plusp (fill-pointer array))
      (funcall callback (coerce array 'string))
      (setf (fill-pointer array) 0))))

(defclass line-char-buffer (char-buffer)
  ((current-line-count :initform 0
                       :accessor buffer-current-line-count)))

(defmethod initialize-instance :after ((self line-char-buffer)
                                       &key &allow-other-keys)
  (setf (%buffer-array self) (make-array (buffer-preferred-size self)
                                         :element-type 'character
                                         :fill-pointer 0
                                         :adjustable t)))

(defmethod flush-char-buffer :after ((self line-char-buffer) &optional force)
  (declare (ignore force))
  (setf (buffer-current-line-count self) 0))

(defmethod add-character-to-buffer (char (self line-char-buffer))
  (let ((array (buffer-array self)))
    (vector-push-extend char array)
    (when (char= char #\Newline)
      (incf (buffer-current-line-count self))
      (when (= (buffer-current-line-count self)
               (buffer-preferred-size self))
        (flush-char-buffer self)))))

(defclass simple-char-buffer (char-buffer)
  ((min-size :initarg :min-size
             :reader buffer-min-size)))

(defmethod initialize-instance :after ((self simple-char-buffer)
                                       &key &allow-other-keys)
  (setf (%buffer-array self) (make-array (buffer-preferred-size self)
                                         :element-type 'character
                                         :fill-pointer 0
                                         :adjustable t)))

(defmethod flush-char-buffer :around ((self simple-char-buffer) &optional force)
  (let* ((array (buffer-array self))
         (min-size (buffer-min-size self))
         (fill (fill-pointer array))
         (floor-fill (if force
                         fill
                         (* (floor fill min-size) min-size))))
    (setf (fill-pointer array) floor-fill)
    (prog1
        (call-next-method)
      (loop :for src :from floor-fill :below fill
         :for dst :from 0
         :do (setf (aref array dst) (aref array src)))
      (setf (fill-pointer array) (- fill floor-fill)))))

(defmethod add-character-to-buffer (char (self simple-char-buffer))
  (let ((array (buffer-array self)))
    (vector-push-extend char array)
    (when (= (fill-pointer array)
             (array-total-size array))
      (flush-char-buffer self))))

(defmethod get-character-from-buffer ((self simple-char-buffer))
  (let ((array (buffer-array self))
        (callback (buffer-callback self)))
    (when (= (read-position self)
             (fill-pointer array))
      (setf (fill-pointer array) (funcall callback array)
            (read-position self) 0))
    (when (< (read-position self)
             (fill-pointer array))
      (prog1
          (aref array (read-position self))
        (incf (read-position self))))))

(defun make-line-buffer (lines-per-buffer callback)
  (make-instance 'line-char-buffer
                 :preferred-size lines-per-buffer
                 :callback callback))

(defun make-character-buffer (block-size blocks-per-buffer callback)
  (make-instance 'simple-char-buffer
                 :min-size block-size
                 :preferred-size (* blocks-per-buffer block-size)
                 :callback callback))
