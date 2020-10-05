(print "hi from init.scm")

;; actions
;; hm since the last changes in ns.scm, the filename is guess given a namespace
;; so no need to autoload
;; (autoload 'rpr.common "rpr/common.scm")

;; making rpr available to any script
(ns-require rpr)

;; guess after that should be the user.scm contents
;; ----
;; ----
;; my scripts (WIP/testing)

;; will appear on Extensions menu
;; (rpr/RegisterAction "test" (lambda () (print "hi there!!")))
(rpr/RegisterGui "Region Items: GUI" "region-items/gui.scm")
;; (rpr/RegisterGui "Gui: some track things" "gui1.scm")
;; (rpr/RegisterGui "gui 2" "gui2.scm")

;; note: to make these actions take into account future changes of the function definition
;; in the files, I have to "dynamically" call them:
;; (((*nss* 'region-items.core) 'select))
;; TODO: actually test this

(ns-require region-items.core :as region-items)
(rpr/RegisterAction "Region Items: Select" region-items/select)
(rpr/RegisterAction "Region Items: Propagate" region-items/propagate)

;; freesound
(ns-require rpr+.freesound)
(rpr/RegisterAction "Freesound: Insert random kick" (lambda ()
						       (rpr+.freesound/insert-random-preview
							"kick"
							:filter '(:duration (0.0 0.5)))))
(rpr/RegisterAction "Freesound: Insert random snare" (lambda ()
						       (rpr+.freesound/insert-random-preview
							"snare"
							:filter '(:duration (0.0 0.5)))))

(comment
 (ns-doc rpr)
 (rpr/GetSelectedTrack 0 0)

 )
