;;;; package.lisp

(cl:in-package cl-user)


(defpackage "https://github.com/g000001/srfi-11"
  (:export let-values
           let*-values))


(defpackage "https://github.com/g000001/srfi-11#internals"
  (:use "https://github.com/g000001/srfi-11"
        cl
        fiveam
        mbe))


;;; *EOF*
