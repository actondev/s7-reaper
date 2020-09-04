(ns rpr.gen
    :doc "Generating functions from the action list"
    :require ((rpr)
	      (aod.c.string :as s)))
;; (require case.scm)

(define (gen)
  ;; (print "geeen 2")
  ;; (print "first" (rpr/CF_EnumerateActions 0 0))
  ;; (print "second "(rpr/CF_EnumerateActions 0 0))

  (let ((limit 100))
    (let loop ((i 1))
      (let* ((id+name (rpr/CF_EnumerateActions 0 i))
	     (id (car id+name))
	     (name (cadr id+name)))
	(if (and (> id 0)
		 (< i limit))
	    (begin
	      (print "id" id "name" name)
	      (loop (inc i)))))))
   
    
  ;; (rpr/CF_EnumerateActions 0 0)
  )

(define (gen-regex regex)
  ;; (print "geeen 2")
  ;; (print "first" (rpr/CF_EnumerateActions 0 0))
  ;; (print "second "(rpr/CF_EnumerateActions 0 0))

  (let ((limit 10000)
	(hits 0))
    (let loop ((i 1))
      (let* ((id+name (rpr/CF_EnumerateActions 0 i))
	     (id (car id+name))
	     (name (cadr id+name)))
	(if (and (> id 0)
		 (< hits limit))
	    (begin
	      (when (s/search name regex)
		(set! hits (inc hits))
		;; (print "id" id "name" name "match" (r/match-at 1))
		(let ((fun-name (s/lowercase (s/replace (s/match-at 1) " " "-"))))
		  (print fun-name)
		  #f)
		)
	      (loop (inc i))))))
    (print "hits " hits)))




(comment
 ;; hits  1250 WITH the "numbered" actions
 (gen-regex "^Track: (.+)$")
 ;; 200 hits
 (gen-regex "^Track: ([^0-9]+)$")

 ;; 170
 (gen-regex "^Item: ([^0-9]+)$")

 ;; 22
 (gen-regex "^Time selection: ([^0-9]+)$")

 (s/search "Track: select-track-84" "^Track: ([^0123456789]+)$")
 )



(define (gen-file the-ns file regex)
  (call-with-output-file file
    (lambda (out)
      ;; paredit freaks out with multi-line strings
      (format out "(ns ~A\n  :require ((rpr)))\n\n(define cmd rpr/Main_OnCommand)\n\n" the-ns)
      (let loop ((i 1))
	(let* ((id+name (rpr/CF_EnumerateActions 0 i))
	       (id (car id+name))
	       (name (cadr id+name)))
	  (if (and (> id 0))
	      (begin
		(when (s/search name regex)
		  (let ((fun-name (s/lowercase
				   (s/replace (s/match-at 1) "[ ()/]" "-"))))
		    (format out "(define (~A) (cmd ~A))\n" fun-name id )))
		(loop (inc i)))))))))

(comment
 (gen-file
  "rpr.gen.time-selection"
  "src/scheme/rpr/gen/time_selection.scm"
  "^Time selection: ([^0-9]+)$")

 (gen-file
  "rpr.gen.track"
  "src/scheme/rpr/gen/track.scm"
  "^Track: ([^0-9]+)$")

 (gen-file
  "rpr.gen.item"
  "src/scheme/rpr/gen/item.scm"
  "^Item: ([^0-9]+)$")
 )

(comment
 (gen)
 (case* "Track: Set volume for selected tracks (MIDI CC/OSC only)"
	((#<r:"Track: ">) #t))

 (case* "axb" ((#<"a.b">) #t))
 (case* "bb" ((#<"bb">) #<foo>)
	(else 'oops))
 match
;;
 )
