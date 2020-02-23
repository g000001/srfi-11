;;;; srfi-11.asd

(cl:in-package :asdf)

(defsystem :srfi-11
  :version "20200223"
  :description "SRFI 11 for CL: Syntax for receiving multiple values"
  :long-description "SRFI 11 for CL: Syntax for receiving multiple values
https://srfi.schemers.org/srfi-11"
  :author "Lars T Hansen"
  :maintainer "CHIBA Masaomi"
  :serial t
  :depends-on (:mbe :fiveam)
  :components ((:file "package")
               (:file "srfi-11")))

(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-11))))
  (let ((name "https://github.com/g000001/srfi-11")
        (nickname :srfi-11))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-11))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-11#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-11)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))

