(ns rpr.time
    :require ((rpr.macros)
	      (rpr.common)))


(define-macro (save-cursor-position . body)
  (let ((pos (rpr/GetCursorPosition)))
    `(begin
       (let ((res (,rpr.macros/safe ,@body)))
	 (rpr/SetEditCurPos ,pos)
	 res))))

(define (move-cursor-left)
  ;; View: Move cursor left to grid division
  (rpr.common/cmd 40646)
  )

(define (move-cursor-right)
  ;; View: Move cursor right to grid division
  (rpr.common/cmd 40647)
  )

(define (move-cursor n)
  (if (> n 0)
      (dotimes (i n) (move-cursor-right))
      (dotimes (i (- n)) (move-cursor-left))))

(define-macro (with-grid grid . body)
  (let ((prev-grid (rpr/GetSetProjectGrid 0)))
    `(begin
       (rpr/GetSetProjectGrid 0 ,grid)
       (let ((res (,rpr.macros/safe ,@body)))
	 (rpr/GetSetProjectGrid 0 ,prev-grid)
	 res))))

(comment
 (rpr/GetCursorPosition)

 (save-cursor-position
  (move-cursor 10)
  (rpr/GetCursorPosition)
  )
 )

(comment
 (rpr/GetSetProjectGrid 0)
 (rpr/GetSetProjectGrid 0 1/4)
 (with-grid 1/16
	    (print "set grid to " (rpr/GetSetProjectGrid 0))
	    )
 
 (ns-doc 'rpr 'GetSet_LoopTimeRange)
 (rpr/GetCursorPosition)
 "(GetSet_LoopTimeRange set? loop? start end allow-auto-seek)"
 )
