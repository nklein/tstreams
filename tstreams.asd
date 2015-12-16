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
   (:module "core/src"
    :components ((:file "package")
                 (:file "generics" :depends-on ("package"))
                 (:file "base" :depends-on ("package"
                                            "generics"))
                 (:file "output" :depends-on ("package"
                                              "generics"
                                              "base"))
                 (:file "char-output" :depends-on ("package"
                                                   "output"))
                 (:file "char-char-output" :depends-on ("package"
                                                        "char-output"))
                 (:file "char-byte-output" :depends-on ("package"
                                                        "char-output"))
                 (:file "byte-output" :depends-on ("package"
                                                   "output"))
                 (:file "byte-char-output" :depends-on ("package"
                                                        "byte-output"))
                 (:file "byte-byte-output" :depends-on ("package"
                                                        "byte-output"))))))

(asdf:defsystem #:tstreams-test
  :description "Tests for the TSTREAMS package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151216"
  :license "UNLICENSE"
  :depends-on ((:version #:tstreams "0.1.20151216")
               #:nst)
  :components
  ((:module "core/test"
    :components ((:file "package")
                 (:file "criteria" :depends-on ("package"))
                 (:file "exports" :depends-on ("package"
                                               "criteria"))
                 (:file "run" :depends-on ("package"
                                           "exports"))))))
