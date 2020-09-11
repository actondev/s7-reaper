(ns rpr.common)

(define (cmd id)
  (cond ((number? id)
	 (rpr/Main_OnCommand id))
	((string? id)
	 (rpr/Main_OnCommand
	  (rpr/NamedCommandLookup id)))
	(else (print "invalid command id" id))))
