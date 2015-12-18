;;;; core/src/package.lisp

(defpackage #:tstreams
  (:use #:cl)
  ;; generics.lisp (input streams)
  (:export #:characters-from-input-stream
           #:bytes-from-input-stream)
  ;; base.lisp
  (:export #:tstreamp)
  ;; output.lisp
  (:export #:output-tstream-p
           #:character-output-stream-p
           #:binary-output-stream-p)
  ;; output-char.lisp
  (:export #:character-output-tstream-p
           #:characters-to-output-stream)
  ;; output-char-char.lisp
  (:export #:character-to-character-output-tstream
           #:character-to-character-output-tstream-p
           #:make-noop-character-to-character-output-tstream)
  ;; output-char-byte.lisp
  (:export #:character-to-binary-output-tstream
           #:character-to-binary-output-tstream-p
           #:characters-to-binary-output-stream)
  ;; output-byte.lisp
  (:export #:binary-output-tstream-p
           #:bytes-to-output-stream)
  ;; output-byte-char.lisp
  (:export #:binary-to-character-output-tstream
           #:binary-to-character-output-tstream-p)
  ;; output-byte-byte.lisp
  (:export #:binary-to-binary-output-tstream
           #:binary-to-binary-output-tstream-p
           #:bytes-to-binary-output-stream
           #:make-noop-binary-to-binary-output-tstream))
