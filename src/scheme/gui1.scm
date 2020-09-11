(ns rootlet
    :require ((aod.c.imgui :as ig)
	      (aod.imgui.macros :as igm)
	      (rpr.actions.track :as a.track)))

(print "hi from gui1.scm")

(define (draw)
  ;; (print "drawing")
  (igm/maximized
   ("s7rpr gui1")
   (ig/text "hi there")
   (when (ig/button "Insert new track")
     (print "will insert new track")
     (a.track/insert-new-track)
     )
   ;; 
   ))
