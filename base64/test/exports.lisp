;;;; base64/test/exports.lisp

(in-package #:tstreams-base64-test)

(nst:def-test-group exports ()
  (nst:def-test exports-constructors
      (:each (:all (publicp :tstreams-base64)
                   (fdocumentationp :tstreams-base64)))
    '(#:make-base64-binary-to-character-output-tstream)))
