;;;; base64/test/output.lisp

(in-package #:tstreams-base64-test)

(nst:def-test-group output-base64 ()
  (nst:def-test binary-to-character-base64-type
      (:all
       (:predicate tstreams:tstreamp)
       (:predicate tstreams:output-tstream-p)
       (:not (:predicate tstreams:character-output-tstream-p))
       (:not (:predicate tstreams:character-to-character-output-tstream-p))
       (:not (:predicate tstreams:character-to-binary-output-tstream-p))
       (:predicate tstreams:binary-output-tstream-p)
       (:predicate tstreams:binary-to-character-output-tstream-p)
       (:not (:predicate tstreams:binary-to-binary-output-tstream-p)))
    (with-open-stream (out (make-string-output-stream))
      (tstreams-base64:make-base64-binary-to-character-output-tstream out)))

  (nst:def-test binary-to-character-base64-no-extra-bytes
      (:equalp "YWJjZGVmZ2hp")
    (with-output-to-string (out)
      (with-open-stream
          (base64
           (tstreams-base64:make-base64-binary-to-character-output-tstream
              out))
        (write-sequence #(97 98 99 100) base64)
        (write-byte 101 base64)
        (write-byte 102 base64)
        (write-byte 103 base64)
        (write-sequence #(104 105) base64))))

  (nst:def-test binary-to-character-base64-one-extra-byte
      (:equalp "YWJjZGVmZ2hpag==")
    (with-output-to-string (out)
      (with-open-stream
          (base64
           (tstreams-base64:make-base64-binary-to-character-output-tstream
              out))
        (write-sequence #(97 98 99 100) base64)
        (write-byte 101 base64)
        (write-byte 102 base64)
        (write-byte 103 base64)
        (write-sequence #(104 105 106) base64))))

  (nst:def-test binary-to-character-base64-two-extra-bytes
      (:equalp "YWJjZGVmZ2hpams=")
    (with-output-to-string (out)
      (with-open-stream
          (base64
           (tstreams-base64:make-base64-binary-to-character-output-tstream
              out))
        (write-sequence #(97 98 99 100) base64)
        (write-byte 101 base64)
        (write-byte 102 base64)
        (write-byte 103 base64)
        (write-sequence #(104 105 106 107) base64))))

  (nst:def-test character-to-utf8-to-base64
      (:equalp "z4Ag4qCP4qCKLCDOuCDioK7ioJ7ioIE=")
    (with-output-to-string (out)
      (tstreams:with-open-streams*
          ((b64
            (tstreams-base64:make-base64-binary-to-character-output-tstream
             out))
           (utf8 (tstreams-utf8:make-utf8-character-to-binary-output-tstream
                   b64)))
        (write-string "π ⠏⠊, θ ⠮⠞⠁" utf8)))))
