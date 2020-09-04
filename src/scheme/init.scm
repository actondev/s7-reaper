(autoload 'rpr.tracks "rpr/tracks.scm")
(autoload 'rpr.items "rpr/items.scm")
(autoload 'rpr.gen "rpr/gen.scm")

(autoload 'rpr.gen.item "rpr/gen/item.scm")
(autoload 'rpr.gen.track "rpr/gen/track.scm")

(print "hi from init.scm")

(ns-require rpr.gen)

;; (ns rootlet
    ;; :require ((rpr.gen)))

(rpr.gen/gen)

(comment
 (ns-require rpr.gen.track :as track)
 (ns-doc 'rpr.gen.track)

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
