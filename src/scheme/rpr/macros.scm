(ns rpr.macros
    :require ((rpr.helpers.track :as h.track)
	      (rpr.actions.track :as a.track)))

(define-macro (-safe . body)
  `(catch #t
	   (lambda ()
	     ,@body)
	   (lambda (tag info)
	     (format *stderr* "Exception occured inside execution body: ~A~%" tag)
	     (apply format *stderr* info)
	     (newline))))

(define-macro (save-track-selection . body)
  (let ((selected (h.track/selected)))
    `(begin
       (,-safe ,@body)
       (,a.track/unselect-all-tracks)
       (for-each (lambda (track)
		   (rpr/SetTrackSelected track #t)
		   )
		 ;; hm.. I have to quote it, if not tries
		 ;; to "eval" the list..
		 ;; aka "calling" the first selected tracks with the rest
		 ;; tracks as arguments... ugh
		 ',selected))))
