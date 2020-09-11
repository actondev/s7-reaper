(ns region-items.core
    :require ((rpr.actions.sws-track :as sws.track)
	      (rpr.actions.item :as actions.item)
	      (rpr.helpers.item :as h.item)))

(define* (select (item (rpr/GetSelectedMediaItem 0 0)))
  ;; time selection to item
  ;; let with list destructuring
  (letd (((start end) (h.item/start-end item)))
    ;; (print "item " item "time:" (list start end))
    (rpr/GetSet_LoopTimeRange #t #f start end #f))
  ;; Gotta call UpdateArrange to see effects in time selection
  ;; TODO maybe first unselect all items also?
  
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
 )

(define* (clear (item (rpr/GetSelectedMediaItem 0 0)))
  (select item)
  ;; unselecting the item.. don't want to delete the "region item"
  (rpr/SetMediaItemSelected item #f)
  ;; update arrange for selection
  ;; not sure if this is needed
  (rpr/UpdateArrange)
  (actions.item/remove-items)
  (rpr/SetMediaItemSelected item #t)
  ;; update arrange for selection
  (rpr/UpdateArrange)
  )

(define* (propagate (item (rpr/GetSelectedMediaItem 0 0)))
  (print "propagating 1")
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
	     (print "pasting..")
	     ;; clearing target
	     (clear target)
	     ;; removing it from selection to be sure (with set
	     ;; selected #f or by unselecting all?)
	     (rpr/SetMediaItemSelected target #f)
	     ;; (actions.item/unselect-all-items)
	     ;; need to update arrange?

	     ;; now, when we'll paste, we guess that the first
	     ;; selected item is the copied (src) region item.
	     
	     ;; pasting to target
	     (letd (((start _) (h.item/start-end target)))
		   (rpr/SetEditCurPos start)
		   ;; (print "pasting")
		   )
	     (actions.item/paste-items-tracks)
	     (let ((copied-item (rpr/GetSelectedMediaItem 0 0)))
	       (h.item/set-only-selected copied-item)
	       ;; UpdateArrange ?
	       (actions.item/remove-items))	     
	     ;; /pasting
	     )
	     
	   )
	 targets))
  (h.item/set-only-selected item)
  (rpr/UpdateArrange)
  )

(comment
  ;; selecting a region item
 (select)
 (rpr/CountSelectedMediaItems)
 ;; propagating: copying the "region" to similarly named region items
 (propagate)
 (define temp-item
   (rpr/GetSelectedMediaItem 0 0))
 (actions.item/unselect-all-items)
 (begin
   (rpr/SetMediaItemSelected temp-item #f)
   (rpr/UpdateArrange))
 ;;
 )
