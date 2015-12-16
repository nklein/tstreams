;;;; core/test/exports.lisp

(in-package #:tstreams-test)

(nst:def-test-group exports ()
  (nst:def-test exports-output-generics (:each (:all publicp
                                                     genericp
                                                     fdocumentationp))
    '(#:characters-to-character-output-stream
      #:bytes-to-character-output-stream
      #:characters-to-binary-output-stream
      #:bytes-to-binary-output-stream))

  (nst:def-test exports-input-generics (:each (:all publicp
                                                    genericp
                                                    fdocumentationp))
    '(#:characters-from-character-input-stream
      #:bytes-from-character-input-stream
      #:characters-from-binary-input-stream
      #:bytes-from-binary-input-stream)))
