;;;; base64/src/package.lisp

(defpackage #:tstreams-base64
  (:use #:cl)
  ;; output-byte-char.lisp
  (:export #:make-base64-binary-to-character-output-tstream))
