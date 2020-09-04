(ns rpr.gen
    :doc "Generating functions from the action list"
    :require ((rpr)
	      (aod.c.regex :as r)))
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
	      (when (r/search name regex)
		(set! hits (inc hits))
		;; (print "id" id "name" name "match" (r/match-at 1))
		(let ((fun-name  (r/replace (r/match-at 1) " " "-")))
		  (print fun-name)
		  #f)
		)
	      (loop (inc i))))))
    (print "hits " hits)))

(comment
 (gen-regex "^Track: (.+)")
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
