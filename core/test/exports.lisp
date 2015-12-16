;;;; core/test/exports.lisp

(in-package #:tstreams-test)

(nst:def-test-group exports ()
  (nst:def-test exports-predicates (:each (:all publicp
                                                fdocumentationp))
    '(#:tstreamp
      #:output-tstream-p
      #:character-output-tstream-p
      #:character-to-character-output-tstream-p
      #:character-to-binary-output-tstream-p
      #:binary-output-tstream-p
      #:binary-to-character-output-tstream-p
      #:binary-to-binary-output-tstream-p))

  (nst:def-test exports-constructors (:each (:all publicp
                                                  fdocumentationp))
    '(#:make-noop-character-to-character-output-tstream
      #:make-noop-binary-to-binary-output-tstream))

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
      #:bytes-from-binary-input-stream))

  (nst:def-test exports-output-classes (:each (:all publicp
                                                    classp
                                                    cdocumentationp))
    '(#:character-to-character-output-tstream
      #:binary-to-character-output-tstream
      #:character-to-binary-output-tstream
      #:binary-to-binary-output-tstream)))
