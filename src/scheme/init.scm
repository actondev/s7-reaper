(print "hi from init.scm")

(ns rootlet
    :require ((rpr)
	      (rpr+.freesound)
	      (region-items.core :as region-items)
	      (rpr.actions.gen)))

(rpr/RegisterGui "Region Items: GUI" "region-items/gui.scm")
(rpr/RegisterAction "Region Items: Select" region-items/select)
(rpr/RegisterAction "Region Items: Propagate" region-items/propagate)

(rpr/RegisterAction "Freesound: Insert random in selected tracks (querying name)"
		    (lambda ()
		      (rpr+.freesound/insert-random)))

(rpr/RegisterAction "Generate actions" (lambda ()
					 (rpr.actions.gen/gen-time-selection)
					 (rpr.actions.gen/gen-track)
					 (rpr.actions.gen/gen-item)
					 (rpr.actions.gen/gen-sws-track)
					 (rpr.actions.gen/gen-sws-item)))

(rpr/RegisterAction "Generate namespaces doc"
		    (lambda ()
		      (load "gen-doc.scm")))

(comment
 (ns-doc rpr)
 (rpr/GetSelectedTrack 0 0)

 )
