(ns rpr.helpers.item
    :require ((rpr.actions.item :as actions.item)
	      (rpr.common)))

(define (set-only-selected item)
  (actions.item/unselect-all-items)
  (rpr/SetMediaItemSelected item #t))

(define (copy)
  (rpr.common/cmd 40698)
  )

(define (selected)
  (map (lambda (idx)
	(rpr/GetSelectedMediaItem 0 idx))
       (range (rpr/CountSelectedMediaItems))))

(define* (track-items
	  ;; project 0, index 0
	  (track (rpr/GetSelectedTrack 0 0))
	  )
  ;; TODO save current track & item selection
  ;; unselecting all items
  (actions.item/unselect-all-items)
  ;; selecting only this tack
  (rpr/SetOnlyTrackSelected track)
  ;; selecting all items of this track
  (actions.item/select-all-items-in-track)
  (selected)
  )

(define* (start-end
	  (item (rpr/GetSelectedMediaItem 0 0)))
  (let ((start (rpr/GetMediaItemInfo_Value item "D_POSITION"))
	(length (rpr/GetMediaItemInfo_Value item "D_LENGTH")))
    (list start (+ start length))))

(comment
 (rpr/CountSelectedMediaItems)
 (map (lambda (idx)
	(rpr/GetSelectedMediaItem 0 idx))
      (range (rpr/CountSelectedMediaItems)))

 (track-items)
 )

(define* (active-take-name (item (rpr/GetSelectedMediaItem 0 0)))
  ;; (print "item is " item)
  (let ((take (rpr/GetActiveTake item)))
    (rpr/GetSetMediaItemTakeInfo_String take "P_NAME")))


(comment
 (active-take-name)
 (rpr/GetSelectedMediaItem 0 0)
 )
