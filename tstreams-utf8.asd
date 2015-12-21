;;;; tstreams-utf8.asd

(asdf:defsystem #:tstreams-utf8
  :description ""
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151221"
  :license "UNLICENSE"
  :depends-on (#:tstreams #:trivial-utf-8)
  :in-order-to ((asdf:test-op (asdf:load-op :tstreams-utf8-test)))
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :tstreams-utf8-test :run-all-tests))
  :components
  ((:static-file "README.md")
   (:static-file "NOTES.md")
   (:module "utf8/src"
    :components ((:file "package")
                 (:file "output-char-byte" :depends-on ("package"))))))

(asdf:defsystem #:tstreams-utf8-test
  :description "Tests for the TSTREAMS package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151221"
  :license "UNLICENSE"
  :depends-on ((:version #:tstreams-utf8 "0.1.20151221")
               #:tstreams-test
               #:fast-io
               #:nst)
  :components
  ((:module "utf8/test"
    :components ((:file "package")
                 (:file "exports" :depends-on ("package"))
                 (:file "output" :depends-on ("package"
                                              "exports"))
                 (:file "run" :depends-on ("package"
                                           "exports"
                                           "output"))))))
