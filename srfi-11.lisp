;;;; srfi-11.lisp

(cl:in-package "https://github.com/g000001/srfi-11#internals")


(def-suite* srfi-11)


;; This code is in the public domain.

(define-syntax let-values
  (syntax-rules ()
    ((let-values (?binding ***) ?body0 ?body1 ***)
     (let-values "bind" (?binding ***) () (progn ?body0 ?body1 ***)))

    ((let-values "bind" () ?tmps ?body)
     (let ?tmps ?body))

    ((let-values "bind" ((?b0 ?e0) ?binding ***) ?tmps ?body)
     (let-values "mktmp" ?b0 ?e0 () (?binding ***) ?tmps ?body))

    ((let-values "mktmp" () ?e0 ?args ?bindings ?tmps ?body)
     (multiple-value-call
         (lambda ?args
           (let-values "bind" ?bindings ?tmps ?body))
       ?e0))

    ((let-values "mktmp" (?a . ?b) ?e0 (?arg ***) ?bindings (?tmp ***) ?body)
     (with ((x (gensym)))
       (let-values "mktmp" ?b ?e0 (?arg *** x) ?bindings (?tmp *** (?a x)) ?body)))

    ((let-values "mktmp" ?a ?e0 (?arg ***) ?bindings (?tmp ***) ?body)
     (with ((x (gensym)))
       (multiple-value-call
           (lambda (?arg *** &rest x)
             (let-values "bind" ?bindings (?tmp *** (?a x)) ?body))
         ?e0)))))


(define-syntax let*-values
  (syntax-rules ()
    ((let*-values () ?body0 ?body1 ***)
     (progn ?body0 ?body1 ***))

    ((let*-values (?binding0 ?binding1 ***) ?body0 ?body1 ***)
     (let-values (?binding0)
       (let*-values (?binding1 ***) ?body0 ?body1 ***)))))


(test let-values
  (is (equal (let-values (((x y z) (values 1 2 3))
                          ((a b c) (values 1 2 3))
                          ((d e f) (values 1 2 3)))
               (list x y z a b c d e f))
             '(1 2 3 1 2 3 1 2 3)))
  (is (equal (let*-values (((x y z) (values 1 2 3))
                           ((x y z) (values x y z))
                           ((x y z) (values x y z)))
               (list x y z))
             '(1 2 3)))
  (signals (error)
           (let-values (((x y z) (values 1 2 3))
                        ((x y z) (values x y z))
                        ((x y z) (values x y z)))
             (list x y z))))


;;; *EOF*
