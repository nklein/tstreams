;;;; core/src/package.lisp

(defpackage #:tstreams
  (:use #:cl)
  (:export #:characters-to-character-output-stream
           #:bytes-to-character-output-stream
           #:characters-to-binary-output-stream
           #:bytes-to-binary-output-stream)
  (:export #:characters-from-character-input-stream
           #:bytes-from-character-input-stream
           #:characters-from-binary-input-stream
           #:bytes-from-binary-input-stream))
