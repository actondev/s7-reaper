(autoload 'rpr.tracks "rpr/tracks.scm")
(autoload 'rpr.items "rpr/items.scm")
(autoload 'rpr.gen "rpr/gen.scm")

(print "hi from init.scm")

(ns-require rpr.gen)

;; (ns rootlet
    ;; :require ((rpr.gen)))

(rpr.gen/gen)

;; (ns-require rpr :as rpr)
;; (print 0 (rpr/CF_EnumerateActions 0 0))
;; (print (rpr/CF_EnumerateActions 0 1))
;; (print (rpr/CF_EnumerateActions 0 12))
;; (print 2 (rpr/CF_EnumerateActions 0 2))

;; (rpr/count-tracks)
