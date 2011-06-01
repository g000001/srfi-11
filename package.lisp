;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-11
  (:export :let-values
           :let*-values))

(defpackage :srfi-11-internal
  (:use :srfi-11 :cl :fiveam :mbe))

