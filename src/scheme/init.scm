(print "hi from init.scm")

(autoload 'rpr.actions.item "rpr/actions/item.scm")
(autoload 'rpr.actions.track "rpr/actions/track.scm")

(ns-require rpr :as rpr)

;; will appear on Extensions menu
(rpr/RegisterAction "test" (lambda () (print "hi there!!")))
(rpr/RegisterGui "Gui: some track things" "gui1.scm")
(rpr/RegisterGui "gui 2" "gui2.scm")
