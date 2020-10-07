(ns rpr.macros
    :doc "Common macros")

(define-macro (safe . body)
  `(catch #t
	   (lambda ()
	     ,@body)
	   (lambda (tag info)
	     (format *stderr* "Exception occured inside execution body: ~A~%" tag)
	     (apply format *stderr* info)
	     (newline))))
