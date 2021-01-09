(print "hi from init.scm")

(ns rootlet
    :require ((rpr)
	      (rpr+.freesound)
	      (region-items.core :as region-items)
	      (arrange.core)
	      (rpr.actions.gen)
	      (rpr.midi)))

(rpr/RegisterGui "Region Items: GUI" "region-items/gui.scm")
(rpr/RegisterAction "Region Items: Select" region-items/select)
(rpr/RegisterAction "Region Items: Propagate" region-items/propagate)

(rpr/RegisterAction "Freesound: Insert random in selected tracks (querying name)"
		    (lambda ()
		      (rpr+.freesound/insert-random)))

(define generate-actions (lambda ()
			   (print "generating actions")
			   (rpr.actions.gen/gen-time-selection)
			   (rpr.actions.gen/gen-track)
			   (rpr.actions.gen/gen-item)
			   (rpr.actions.gen/gen-sws-track)
			   (rpr.actions.gen/gen-sws-item)))
(rpr/RegisterAction "Generate actions" generate-actions)

(rpr/RegisterAction "Generate namespaces doc"
		    (lambda ()
		      (load "gen-doc.scm")))

(comment
 (ns-doc rpr)
 (rpr/GetSelectedTrack 0 0)

 )
