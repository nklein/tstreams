;;;; utf8/test/output.lisp

(in-package #:tstreams-utf8-test)

(nst:def-test-group output-utf8 ()
  (nst:def-test character-to-binary-utf8-type
      (:all
       (:predicate tstreams:tstreamp)
       (:predicate tstreams:output-tstream-p)
       (:predicate tstreams:character-output-tstream-p)
       (:not (:predicate tstreams:character-to-character-output-tstream-p))
       (:predicate tstreams:character-to-binary-output-tstream-p)
       (:not (:predicate tstreams:binary-output-tstream-p))
       (:not (:predicate tstreams:binary-to-character-output-tstream-p))
       (:not (:predicate tstreams:binary-to-binary-output-tstream-p)))
    (with-open-stream (out (make-vector-output-stream))
      (tstreams-utf8:make-utf8-character-to-binary-output-tstream out)))

  (nst:def-test character-to-binary-utf8-on-ascii
      (:equalp #(97 98 99 100 101 102 103 104 105 106))
    (with-output-to-vector (out)
      (with-open-stream
          (utf8 (tstreams-utf8:make-utf8-character-to-binary-output-tstream
                 out))
        (write-string "abcd" utf8)
        (write-char #\e utf8)
        (write-char #\f utf8)
        (write-char #\g utf8)
        (format utf8 "hij"))))

  (nst:def-test character-to-binary-utf8-on-unicode
      (:equalp #(207 128 32 226 160 143 226 160 138 44 32
                 206 184 32 226 160 174 226 160 158 226 160 129))
    (with-output-to-vector (out)
      (with-open-stream
          (utf8 (tstreams-utf8:make-utf8-character-to-binary-output-tstream
                 out))
        (write-string "π ⠏⠊, θ ⠮⠞⠁" utf8)))))
