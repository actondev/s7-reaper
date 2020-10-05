(ns rpr+.freesound
    :require ((freesound.core :as fs)
	      (aod.c.os :as os)
	      (aod.c.curl :as curl)))

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
    (curl/curl url :out dl-path :opts '(:ssl-verify-peer 0))
    (rpr/InsertMedia dl-path mode)))

(comment
 (append "a" "b")
 (insert-random-preview "snare" :filter '(:duration (0.0 0.5)))
 (insert-random-preview "kick" :filter '(:duration (0.0 0.5)))
 )
