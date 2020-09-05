(print "hi from init.scm")

(autoload 'rpr.actions.item "rpr/actions/item.scm")
(autoload 'rpr.actions.track "rpr/actions/track.scm")

(ns-require rpr :as rpr)

(comment
 (ns-require rpr.actions.track :as track)
 (ns-doc 'rpr.actions.track)

 (track/insert-new-track)
 (track/select-all-tracks)
 (track/unselect-all-tracks)
 (track/remove-tracks)
 )

;; (ns-require rpr :as rpr)
;; (print 0 (rpr/CF_EnumerateActions 0 0))
;; (print (rpr/CF_EnumerateActions 0 1))
;; (print (rpr/CF_EnumerateActions 0 12))
;; (print 2 (rpr/CF_EnumerateActions 0 2))

;; (rpr/count-tracks)
