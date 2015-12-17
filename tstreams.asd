;;;; tstreams.asd

(asdf:defsystem #:tstreams
  :description ""
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151216"
  :license "UNLICENSE"
  :depends-on (#:trivial-gray-streams)
  :in-order-to ((asdf:test-op (asdf:load-op :tstreams-test)))
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :tstreams-test :run-all-tests))
  :components
  ((:static-file "README.md")
   (:static-file "NOTES.md")
   (:module "core/src"
    :components ((:file "package")
                 (:file "generics" :depends-on ("package"))
                 (:file "base" :depends-on ("package"
                                            "generics"))
                 (:file "buffer-char" :depends-on ("package"))
                 (:file "output" :depends-on ("package"
                                              "generics"
                                              "base"))
                 (:file "output-char" :depends-on ("package"
                                                   "buffer-char"
                                                   "output"))
                 (:file "output-char-char" :depends-on ("package"
                                                        "output-char"))
                 (:file "output-char-byte" :depends-on ("package"
                                                        "output-char"))
                 (:file "output-byte" :depends-on ("package"
                                                   "output"))
                 (:file "output-byte-char" :depends-on ("package"
                                                        "output-byte"))
                 (:file "output-byte-byte" :depends-on ("package"
                                                        "output-byte"))))))

(asdf:defsystem #:tstreams-test
  :description "Tests for the TSTREAMS package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151216"
  :license "UNLICENSE"
  :depends-on ((:version #:tstreams "0.1.20151216")
               #:fast-io
               #:nst)
  :components
  ((:module "core/test"
    :components ((:file "package")
                 (:file "criteria" :depends-on ("package"))
                 (:file "exports" :depends-on ("package"
                                               "criteria"))
                 (:file "output" :depends-on ("package"
                                              "exports"))
                 (:file "run" :depends-on ("package"
                                           "exports"
                                           "output"))))))
