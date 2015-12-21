;;;; core/src/utility.lisp

(in-package #:tstreams)

(defmacro with-open-streams* (((var stream) &rest more-stream-decls)
                              &body body)
  "The WITH-OPEN-STREAMS* macro turns a LET*-like sequence of stream
initializations into a nested series of WITH-OPEN-STREAM calls.

For example, something like this:

    (with-open-file (in1 in1-filename)
      (with-open-file (in2 in2-filename)
        (with-open-file (in3 in3-filename)
           (with-open-stream (in123 (make-concatenated-stream in1 in2 in3))
              (read-my-data in123)))))

Could be written with this macro as:

    (with-open-streams* ((in1 (open in1-filename))
                         (in2 (open in2-filename))
                         (in3 (open in3-filename))
                         (in123 (make-concatenated-stream in1 in2 in3)))
      (read-my-data in123))"
  (cond
    ((null more-stream-decls)
     `(with-open-stream (,var ,stream)
        ,@body))
    (t
     `(with-open-stream (,var ,stream)
        (with-open-streams* ,more-stream-decls
          ,@body)))))
