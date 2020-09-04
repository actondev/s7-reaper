(ns rpr.actions.gen
    :doc "Generating functions from the action list
The rpr.actions.item/track/time-selection are generated from here"
    :require ((rpr)
	      (aod.c.string :as s)))

(define (gen-file the-ns file regex)
  (call-with-output-file file
    (lambda (out)
      ;; paredit freaks out with multi-line strings
      (format out ";; auto-generated file. see gen.scm\n")
      (format out "(ns ~A\n  :require ((rpr)))\n\n(define cmd rpr/Main_OnCommand)\n\n" the-ns)
      (let loop ((i 1))
	(let* ((id+name (rpr/CF_EnumerateActions 0 i))
	       (id (car id+name))
	       (name (cadr id+name)))
	  (if (> id 0)
	      (begin
		(when (s/search name regex)
		  (let ((fun-name (s/lowercase
				   (s/replace (s/match-at 1) "[ ()/]" "-"))))
		    (format out "(define (~A) (cmd ~A))\n" fun-name id )))
		(loop (inc i)))))))))

(comment
 (gen-file
  "rpr.actions.time-selection"
  "src/scheme/rpr/actions/time_selection.scm"
  "^Time selection: ([^0-9]+)$")

 (gen-file
  "rpr.actions.track"
  "src/scheme/rpr/actions/track.scm"
  "^Track: ([^0-9]+)$")

 (gen-file
  "rpr.actions.item"
  "src/scheme/rpr/actions/item.scm"
  "^Item: ([^0-9]+)$")
 )

