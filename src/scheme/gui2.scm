(ns rootlet
    :require ((aod.c.imgui :as ig)
	      (aod.imgui.macros :as igm)))

(print "hi from gui2.scm")

(define (draw)
  ;; (print "here drawing!!")
  ;; huh.. if I call begin it crashes
  (ig/begin "gui 2")
  (ig/text "hi there")
  (ig/end))
