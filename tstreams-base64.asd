;;;; tstreams-utf8.asd

(asdf:defsystem #:tstreams-base64
  :description ""
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.2.20151221"
  :license "UNLICENSE"
  :depends-on (#:tstreams #:s-base64)
  :in-order-to ((asdf:test-op (asdf:load-op :tstreams-base64-test)))
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :tstreams-base64-test :run-all-tests))
  :components
  ((:static-file "README.md")
   (:static-file "NOTES.md")
   (:module "base64/src"
    :components ((:file "package")
                 (:file "output-byte-char" :depends-on ("package"))))))

(asdf:defsystem #:tstreams-base64-test
  :description "Tests for the TSTREAMS package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.2.20151221"
  :license "UNLICENSE"
  :depends-on ((:version #:tstreams-base64 "0.2.20151221")
               #:tstreams-test
               #:tstreams-utf8
               #:fast-io
               #:nst)
  :components
  ((:module "base64/test"
    :components ((:file "package")
                 (:file "exports" :depends-on ("package"))
                 (:file "output" :depends-on ("package"
                                              "exports"))
                 (:file "run" :depends-on ("package"
                                           "exports"
                                           "output"))))))
