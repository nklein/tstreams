;;;; utf8/test/exports.lisp

(in-package #:tstreams-utf8-test)

(nst:def-test-group exports ()
  (nst:def-test exports-constructors
      (:each (:all (publicp :tstreams-utf8)
                   (fdocumentationp :tstreams-utf8)))
    '(#:make-utf8-character-to-binary-output-tstream)))
