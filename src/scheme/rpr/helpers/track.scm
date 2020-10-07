(ns rpr.helpers.track
    :require ((rpr.actions.track :as a.track)
	      (rpr.macros)
	      (rpr.actions.sws-track :as sws-track)))


(define (selected)
  (map (lambda (idx)
	(rpr/GetSelectedTrack 0 idx))
       (range (rpr/CountSelectedTracks))))

(define* (select-only-children (track (rpr/GetSelectedTrack 0 0)))
  (rpr/SetOnlyTrackSelected track)
  (sws-track/select-children-of-selected-folder-track<s>)
  (rpr/SetTrackSelected track #f))

(define* (name (track (rpr/GetSelectedTrack 0 0)))
  (rpr/GetSetMediaTrackInfo_String track "P_NAME"))

;; copied from macros.. cause if not, circular dependency.. ugh!
(define-macro (save-selection . body)
  (let ((the-selected (selected)))
    `(begin
       (let ((res (,rpr.macros/safe ,@body)))
	 (,a.track/unselect-all-tracks)
	 (for-each (lambda (track)
		     (rpr/SetTrackSelected track #t))
		   ;; hm.. I have to quote it, if not tries
		   ;; to "eval" the list..
		   ;; aka "calling" the first selected tracks with the rest
		   ;; tracks as arguments... ugh
		   ',the-selected)
	 res))))

(define* (children (track (rpr/GetSelectedTrack 0 0)))
  (save-selection
   (a.track/unselect-all-tracks)
   (select-only-children track)
   (selected)))

(comment
 (selected)
 (children)
 (select-only-children)
 (sws-track/select-children-of-selected-folder-track<s>)
 )
