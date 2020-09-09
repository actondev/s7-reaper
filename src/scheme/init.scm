(print "hi from init.scm")

;; actions
(autoload 'rpr.actions.item "rpr/actions/item.scm")
(autoload 'rpr.actions.track "rpr/actions/track.scm")
(autoload 'rpr.actions.sws-track "rpr/actions/sws-track.scm")
(autoload 'rpr.actions.sws-item "rpr/actions/sws-item.scm")
;; common
(autoload 'rpr.common "rpr/common.scm")
;; making rpr available to any script
(ns-require rpr :as rpr)

;; guess after that should be the user.scm contents
;; ----
;; ----
;; my scripts (WIP/testing)
(autoload 'aod.region-items "aod/region-items.scm")

(ns-require aod.region-items :as region-items)

;; will appear on Extensions menu
(rpr/RegisterAction "test" (lambda () (print "hi there!!")))
(rpr/RegisterGui "Gui: some track things" "gui1.scm")
(rpr/RegisterGui "gui 2" "gui2.scm")
(rpr/RegisterAction "Region Items: Select" region-items/select)

(comment
 (ns-doc rpr)

 )
