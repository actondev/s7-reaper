(print "hi from init.scm")

;; actions
(autoload 'rpr.actions.item "rpr/actions/item.scm")
(autoload 'rpr.actions.track "rpr/actions/track.scm")
(autoload 'rpr.actions.sws-track "rpr/actions/sws-track.scm")
(autoload 'rpr.actions.sws-item "rpr/actions/sws-item.scm")

;; helpers
(autoload 'rpr.helpers.item "rpr/helpers/item.scm")

;; common
(autoload 'rpr.common "rpr/common.scm")
;; making rpr available to any script
(ns-require rpr :as rpr)

;; guess after that should be the user.scm contents
;; ----
;; ----
;; my scripts (WIP/testing)
(autoload 'region-items.core "region-items/core.scm")


;; requires
(ns rootlet
    :require ((region-items.core :as region-items)))

;; will appear on Extensions menu
(rpr/RegisterAction "test" (lambda () (print "hi there!!")))
(rpr/RegisterGui "Gui: some track things" "gui1.scm")
(rpr/RegisterGui "gui 2" "gui2.scm")
;; note: to make these actions take into account future changes of the function definition
;; in the files, I have to "dynamically" call them:
;; (((*nss* 'region-items.core) 'select))
;; TODO: actually test this
(rpr/RegisterAction "Region Items: Select" region-items/select)
(rpr/RegisterAction "Region Items: Propagate" region-items/propagate)

(comment
 (ns-doc rpr)
 (rpr/GetSelectedTrack 0 0)

 )
