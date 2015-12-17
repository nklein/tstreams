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
