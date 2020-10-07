(ns rpr.helpers.track)


(define (selected)
  (map (lambda (idx)
	(rpr/GetSelectedTrack 0 idx))
       (range (rpr/CountSelectedTracks))))

(define* (name (track (rpr/GetSelectedTrack 0 0)))
  (rpr/GetSetMediaTrackInfo_String track "P_NAME"))

(comment
 (selected)
 )
