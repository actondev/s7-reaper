(ns rootlet
    :require ((aod.c.imgui :as ig)
	      (aod.imgui.macros :as igm)
	      (region-items.core :as ri)
	      ))

(print "region items gui opened")

(define (draw)
  ;; (print "drawing")
  (igm/maximized
   ("Region Items")
   (ig/text "Region Items")
   (igm/horizontal
    (when (ig/button "Select")
      (ri/select))
    (when (ig/button "Propagate")
      (ri/propagate))
    (when (ig/button "Clear")
      (ri/clear)))
   ;; /draw
   ))
