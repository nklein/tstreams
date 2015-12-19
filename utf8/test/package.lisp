;;;; utf8/test/package.lisp

(defpackage #:tstreams-utf8-test
  (:use #:cl)
  (:import-from #:tstreams-test
                #:publicp
                #:fdocumentationp)
  (:import-from #:tstreams-test
                #:make-vector-output-stream
                #:buffer-to-vector
                #:with-output-to-vector)
  (:export #:run-all-tests))
