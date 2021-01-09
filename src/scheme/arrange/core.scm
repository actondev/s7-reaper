(ns arrange.core
    :require ((rpr.helpers.track :as h.track)
	      (rpr.helpers.item :as h.item)
	      (rpr.actions.item :as a.item)
	      (rpr.time :as time)
	      (s7bi.string.c :as s)))

(define* (filter-tracks-regex tracks regex)
  ;; returns a list of matching tracks
  (filter (lambda (track)
	    (s/search (h.track/name track) regex)
	    )
	  tracks))

(define* (arrange-track arrangement
			(track (rpr/GetSelectedTrack 0 0))
			(grid 1/16))
  (h.track/save-selection
   (time/save-cursor-position
    (time/with-grid
     grid
     (let ((first-item (rpr/GetTrackMediaItem track 0)))
       (h.item/set-only-selected first-item)
       (h.item/copy)
       ;; also "touching" the track to fix the copy/paste target
       (rpr/SetOnlyTrackSelected track)
       (for-each (lambda (arr)
		   (time/save-cursor-position
		    (cond ((equivalent? "x" arr)
			   ;; paste item
			   (begin
			     ;; (print "pasting")
			     (a.item/paste-items-tracks))
			   )))
		   (time/move-cursor-right)
		   )
		 arrangement)
       )))))

(define* (arrange-children arrangements
			   (track (rpr/GetSelectedTrack 0 0))
			   (grid 1/16))
  (let ((children (h.track/children track)))
    (for-each
     (lambda (track-arrangement)
       ;; we have to find the matching child track
       (for-each
	(lambda (track)
	  ;; track arrangement: car is the "track name"
	  ;; cdr contains the beat info
	  (arrange-track :track track :arrangement (cdr track-arrangement)
			 :grid grid)
	  )
	(filter-tracks-regex children (car track-arrangement))))
     arrangements)))


(comment
 (arrange-track :arrangement '("x" "" "" "" "" "x" "" ""))

 (arrange-children :arrangements '(("kick" "x" "" "" "" "" "x" "" "") ("snare" "" "" "x" "" "" "" "x" "")))
 ;;
 )
