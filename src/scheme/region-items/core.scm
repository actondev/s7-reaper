(ns region-items.core
    :require ((rpr.item)
	      (rpr.actions.sws-track :as sws.track)
	      (rpr.actions.item :as actions.item)
	      (rpr.helpers.item :as h.item)))

(comment
 (if (rpr/GetSelectedMediaItem 0)
     1
     2)

 (if () 1 2)
 )

(define* (select (item (rpr/GetSelectedMediaItem 0 0)))
  ;; time selection to item
  ;; let with list destructuring
  (letd (((start end) (rpr.item/start-end item)))
    (print "item " item "time:" (list start end))
    (rpr/GetSet_LoopTimeRange #t #f start end #f))
  ;; Gotta call UpdateArrange to see effects in time selection
  
  ;; select children tracks of item track
  (let ((track (rpr/GetMediaItem_Track item)))
    (rpr/SetOnlyTrackSelected track)
    (sws.track/select-children-of-selected-folder-track{s})
    (actions.item/select-all-items-on-selected-tracks-in-current-time-selection)
    (rpr/SetOnlyTrackSelected track)
    (rpr/UpdateArrange))
  ;; /select
  )

(comment
 (select)
 (rpr.actions.sws-track/select-children-of-selected-folder-track{s})
 (documentation rpr/GetSet_LoopTimeRange)
 (ns-doc 'rpr 'GetSet_LoopTimeRange)
 )

(define* (propagate (item (rpr/GetSelectedMediaItem 0 0)))
  ;; copying
  (select item)
  (actions.item/copy-selected-area-of-items)
  
  (let* ((track (rpr/GetMediaItem_Track item))
	 (targets (h.item/track-items track))
	 (item-take-name (h.item/active-take-name item)))
    (map (lambda (target)
	   ;; (print "target is " target "source item" item
	   ;; 	  "eq?" (equivalent? target item))
	   (when
	       (and
		(not (equivalent? target item))
		(equivalent? (h.item/active-take-name target)
			     item-take-name))
	     ;; pasting to target
	     ;; TODO set edit cursor
	     (print "pasting")
	     (actions.item/paste-items-tracks))
	     
	   )
	 targets))
  (h.item/set-only-selected item)
  (rpr/UpdateArrange)
  )

(comment
 (propagate)
 ;;
 )
