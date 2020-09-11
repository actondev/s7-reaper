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
      (format out "(ns ~A\n  :require ((rpr) (rpr.common)))\n(define cmd rpr.common/cmd) ;; runs either native actions (with number id) or named actions (eg SWS)\n\n" the-ns)
      (let loop ((i 1))
	(let* ((id+name (rpr/CF_EnumerateActions 0 i))
	       (id (car id+name))
	       (name (cadr id+name)))
	  (if (> id 0)
	      (begin
		(when (s/search name regex)
		  (let ((fun-name
			 ;; TODO implement -> and ->> clojure macros
			 (s/lowercase
			  (s/replace
			   (s/replace 
			    (s/replace (s/match-at 1) "[ /]" "-")
			    "[(]" "{")
			   "[)]" "}"))))
		    (if-let (named-id (rpr/ReverseNamedCommandLookup id))
			    ;; named command: appending underscore before the returned name id
			    (format out "(define (~A) (cmd \"_~A\"))\n" fun-name named-id)
			    ;; native action
			    (format out "(define (~A) (cmd ~A))\n" fun-name id)
			    )))
		(loop (inc i)))))))))

(comment
 (rpr/ReverseNamedCommandLookup 53001)
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

 (gen-file
  "rpr.actions.sws-track"
  "src/scheme/rpr/actions/sws-track.scm"
  "^SWS: ((?!.*[0-9']).*track.*)$")

 (gen-file
  "rpr.actions.sws-item"
  "src/scheme/rpr/actions/sws-item.scm"
  "^SWS: ((?!.*[0-9']).*item.*)$")

 (comment
  (s/lowercase
			  (s/replace
			   (s/replace 
			    (s/replace "SWS: Set selected track(s)/item(s) to one random color"
				       "[ /]" "-")
			    "[(]" "{")
			   "[)]" "}"))
  )
 )

