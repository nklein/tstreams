;;;; base64/test/package.lisp

(defpackage #:tstreams-base64-test
  (:use #:cl)
  (:import-from #:tstreams-test
                #:publicp
                #:fdocumentationp)
  (:export #:run-all-tests))
