;;;; tstreams.asd

(asdf:defsystem #:tstreams
  :description ""
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.2.20151221"
  :license "UNLICENSE"
  :depends-on (#:trivial-gray-streams)
  :in-order-to ((asdf:test-op (asdf:test-op :tstreams-test)))
  :components
  ((:static-file "README.md")
   (:static-file "NOTES.md")
   (:module "core/src"
    :components ((:file "package")
                 (:file "utility" :depends-on ("package"))
                 (:file "generics" :depends-on ("package"))
                 (:file "base" :depends-on ("package"))
                 (:file "buffer-char" :depends-on ("package"))
                 (:file "buffer-byte" :depends-on ("package"))
                 (:file "output" :depends-on ("package"
                                              "base"))
                 (:file "output-char" :depends-on ("package"
                                                   "buffer-char"
                                                   "output"))
                 (:file "output-char-char" :depends-on ("package"
                                                        "output-char"))
                 (:file "output-char-byte" :depends-on ("package"
                                                        "output-char"))
                 (:file "output-byte" :depends-on ("package"
                                                   "buffer-byte"
                                                   "output"))
                 (:file "output-byte-char" :depends-on ("package"
                                                        "output-byte"))
                 (:file "output-byte-byte" :depends-on ("package"
                                                        "output-byte"))
                 (:file "input" :depends-on ("package"
                                             "base"))
                 (:file "input-char" :depends-on ("package"
                                                  "base"
                                                  "input"))
                 (:file "input-char-char" :depends-on ("package"
                                                       "base"
                                                       "input"
                                                       "input-char"))))))

(asdf:defsystem #:tstreams-test
  :description "Tests for the TSTREAMS package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.2.20151221"
  :license "UNLICENSE"
  :depends-on ((:version #:tstreams "0.2.20151221")
               #:fast-io
               #:nst)
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :tstreams-test :run-all-tests))
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
