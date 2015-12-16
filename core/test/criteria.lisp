;;;; core/test/criteria.lisp

(in-package #:tstreams-test)

(defun find-package-symbol (sym &optional (package :tstreams))
  (find-symbol (string sym) package))

(defun externalp (sym)
  (eql (nth-value 1 (find-package-symbol sym (symbol-package sym)))
       :external))

(defmacro criterion-assert-case ((condition &body body) &rest more-clauses)
  (flet ((criterion-clause (clause)
           (destructuring-bind (condition format &rest args) clause
             `((not ,condition)
               (nst:make-failure-report :format ,format
                                        :args (list ,@args))))))
    `(cond
       ,@(mapcar #'criterion-clause (list* (list* condition body)
                                           more-clauses))
       (t
        (nst:make-success-report)))))

(nst:def-criterion (publicp (&optional (package :tstreams)) (sym))
  (let ((psym (find-package-symbol sym package)))
    (criterion-assert-case
     (psym
      "Symbol ~A does not exist in package ~A" sym package)
     ((externalp psym)
      "Symbol ~A not external in package ~A" sym package))))

(nst:def-criterion (genericp (&optional (package :tstreams)) (sym))
  (let* ((psym (find-package-symbol sym package))
         (fn (ignore-errors (fdefinition psym))))
    (criterion-assert-case
     (psym
      "Symbol ~A does not exist in package ~A" sym package)
     (fn
      "No such function ~A in package ~A" sym package)
     ((typep fn 'generic-function)
      "Symbol ~A not a generic function in package ~A" sym package))))

(nst:def-criterion (fdocumentationp (&optional (package :tstreams)) (sym))
  (let* ((psym (find-package-symbol sym package))
         (fn (ignore-errors (fdefinition psym))))
    (criterion-assert-case
     (psym
      "Symbol ~A does not exist in package ~A" sym package)
     (fn
      "No such function ~A in package ~A" sym package)
     ((documentation fn t)
      "Function ~A is not documented in package ~A" sym package))))
