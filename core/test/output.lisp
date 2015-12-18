;;;; core/test/output.lisp

(in-package #:tstreams-test)

(defclass binary-vector-output-stream
    (fast-io:fast-output-stream
     trivial-gray-streams:fundamental-binary-output-stream)
  ())

(defun make-vector-output-stream ()
  (make-instance 'binary-vector-output-stream))

(nst:def-test-group output-noop ()
  (nst:def-test character-to-character-noop-type
      (:all
       (:predicate tstreams:tstreamp)
       (:predicate tstreams:output-tstream-p)
       (:predicate tstreams:character-output-tstream-p)
       (:predicate tstreams:character-to-character-output-tstream-p)
       (:not (:predicate tstreams:character-to-binary-output-tstream-p))
       (:not (:predicate tstreams:binary-output-tstream-p))
       (:not (:predicate tstreams:binary-to-character-output-tstream-p))
       (:not (:predicate tstreams:binary-to-binary-output-tstream-p)))
    (with-open-stream (out (make-string-output-stream))
      (tstreams:make-noop-character-to-character-output-tstream out)))

  (nst:def-test character-to-character-noop-is-noop (:equalp "abcdefghij")
    (with-output-to-string (out)
      (with-open-stream
          (noop (tstreams:make-noop-character-to-character-output-tstream
                 out))
        (write-string "abcd" noop)
        (write-char #\e noop)
        (write-char #\f noop)
        (write-char #\g noop)
        (format noop "hij"))))

  (nst:def-test character-to-character-noop-line-buffer
      (:seq (:equalp "")
            (:equalp (format nil "abcd~%efg~%"))
            (:equalp "")
            (:equalp (format nil "hij~%klm")))
    (let ((lines))
      (with-open-stream (out (make-string-output-stream))
        (with-open-stream
            (noop (tstreams:make-noop-character-to-character-output-tstream
                   out
                   :block-size :line
                   :blocks-per-buffer 2))
          (format noop "abcd~%")
          (push (get-output-stream-string out) lines)
          (format noop "efg~%")
          (push (get-output-stream-string out) lines)
          (format noop "hij~%")
          (format noop "klm")
          (push (get-output-stream-string out) lines))
        (push (get-output-stream-string out) lines))
      (reverse lines)))

  (nst:def-test character-to-character-noop-character-buffer
      (:seq (:equalp "")
            (:equalp "abcdefgh")
            (:equalp "ijklmnop")
            (:equalp "qrs"))
    (let ((lines))
      (with-open-stream (out (make-string-output-stream))
        (with-open-stream
            (noop (tstreams:make-noop-character-to-character-output-tstream
                   out
                   :block-size 4
                   :blocks-per-buffer 2))
          (format noop "abcdefg")
          (push (get-output-stream-string out) lines)
          (format noop "hijkl")
          (push (get-output-stream-string out) lines)
          (format noop "mnopqrs")
          (push (get-output-stream-string out) lines))
        (push (get-output-stream-string out) lines))
      (reverse lines)))

  (nst:def-test character-to-character-pipeline (:equalp "abcdefghij")
    (with-output-to-string (out)
      (tstreams:with-open-streams*
          ((third (tstreams:make-noop-character-to-character-output-tstream
                   out))
           (second (tstreams:make-noop-character-to-character-output-tstream
                    third))
           (first (tstreams:make-noop-character-to-character-output-tstream
                   second)))
        (write-string "abcd" first)
        (write-char #\e first)
        (write-char #\f first)
        (write-char #\g first)
        (format first "hij"))))

  (nst:def-test binary-to-binary-noop-type
      (:all
       (:predicate tstreams:tstreamp)
       (:predicate tstreams:output-tstream-p)
       (:not (:predicate tstreams:character-output-tstream-p))
       (:not (:predicate tstreams:character-to-character-output-tstream-p))
       (:not (:predicate tstreams:character-to-binary-output-tstream-p))
       (:predicate tstreams:binary-output-tstream-p)
       (:not (:predicate tstreams:binary-to-character-output-tstream-p))
       (:predicate tstreams:binary-to-binary-output-tstream-p))
    (with-open-stream (out (make-vector-output-stream))
      (tstreams:make-noop-binary-to-binary-output-tstream out))))
