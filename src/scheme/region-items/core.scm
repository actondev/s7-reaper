(ns region-items.core
    :require ((rpr.item)
	      (rpr.actions.sws-track :as sws.track)
	      (rpr.actions.item :as actions.item)))

(comment
 (if (rpr/GetSelectedMediaItem 0)
     1
     2)

 (if () 1 2)
 )

(define* (select (item (rpr/GetSelectedMediaItem 0)))
  ;; time selection to item
  (let* ((t.. (rpr.item/start-end item))
	 (start (car t..))
	 (end (cadr t..))
	 )
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
