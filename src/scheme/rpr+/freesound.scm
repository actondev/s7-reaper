(ns rpr+.freesound
    :require ((freesound.core :as fs)
	      (aod.c.os :as os)
	      (aod.c.curl :as curl)
	      (rpr.helpers.track :as h.track)
	      (rpr.actions.sws-track :as act.sws-track)))

(comment
 fs/*token* ;; hmm not here. I guess i disabled *starred* vars from being imported in ns.scm ???
 ((*nss* 'freesound.core) '*token*)
 )

(define *download-dir* (os/temp-directory-path))

(define* (insert-random-preview
	  query
	  (mode 0) ;; the mode to be passed to rpr/InsertMedia
	  filter ;; to be passed to freesound
	  )
  (let* ((url (fs/search&random-preview query :filter filter))
	 (filename (os/path-filename url))
	 (dl-path (format #f "~A/~A" *download-dir* filename)))
    (print "Downloading " dl-path)
    (curl/curl url :out dl-path :opts '(:ssl-verify-peer 0))
    (rpr/InsertMedia dl-path mode)))

(define (insert-random)
  (h.track/save-selection
   (for-each (lambda (track)
	       (print "Inserting random freesound sample in " track)
	       (rpr/SetOnlyTrackSelected track)
	       (insert-random-preview (h.track/name track) :filter '(:duration (0.0 1.0))))
	     (h.track/selected))))

(comment
 (insert-random)
 
 (insert-random-preview "snare" :filter '(:duration (0.0 0.5)))
 (insert-random-preview "kick" :filter '(:duration (0.0 0.5)))
 )
