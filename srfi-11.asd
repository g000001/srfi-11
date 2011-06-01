;;;; srfi-11.asd

(cl:in-package :asdf)

(defsystem :srfi-11
  :serial t
  :depends-on (:mbe)
  :components ((:file "package")
               (:file "srfi-11")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-11))))
  (load-system :srfi-11)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-11-internal :srfi-11))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

