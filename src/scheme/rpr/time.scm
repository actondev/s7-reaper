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



(comment
 (ns-doc 'rpr 'GetSet_LoopTimeRange)
 (rpr/GetCursorPosition)
 "(GetSet_LoopTimeRange set? loop? start end allow-auto-seek)"
 )
