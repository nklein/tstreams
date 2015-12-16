;;;; core/src/package.lisp

(defpackage #:tstreams
  (:use #:cl)
  ;; generics.lisp (input streams)
  (:export #:characters-from-character-input-stream
           #:bytes-from-character-input-stream
           #:characters-from-binary-input-stream
           #:bytes-from-binary-input-stream)
  ;; base.lisp
  (:export #:tstreamp)
  ;; output.lisp
  (:export #:output-tstream-p)
  ;; char-output.lisp
  (:export #:character-output-tstream-p)
  ;; char-char-output.lisp
  (:export #:character-to-character-output-tstream
           #:character-to-character-output-tstream-p
           #:characters-to-character-output-stream)
  ;; char-byte-output.lisp
  (:export #:character-to-binary-output-tstream
           #:character-to-binary-output-tstream-p
           #:characters-to-binary-output-stream)
  ;; byte-output.lisp
  (:export #:binary-output-tstream-p)
  ;; byte-char-output.lisp
  (:export #:binary-to-character-output-tstream
           #:binary-to-character-output-tstream-p
           #:bytes-to-character-output-stream)
  ;; byte-byte-output.lisp
  (:export #:binary-to-binary-output-tstream
           #:binary-to-binary-output-tstream-p
           #:bytes-to-binary-output-stream))
