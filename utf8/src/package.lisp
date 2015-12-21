;;;; utf8/src/package.lisp

(defpackage #:tstreams-utf8
  (:use #:cl)
  ;; output-char-byte.lisp
  (:export #:make-utf8-character-to-binary-output-tstream))
