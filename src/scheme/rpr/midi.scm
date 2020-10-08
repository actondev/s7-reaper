(ns rpr.midi
    :require ((rpr.time)))

(define (-cur-take)
  (rpr/GetActiveTake
   (rpr/GetSelectedMediaItem 0 0))
  )

(define* (delete-all-events (take (-cur-take)))
  (for-each (lambda (idx)
	      ;; turns out I have to go on deleting from the
	      ;; first event
	      ;; if not, weird behavior
	      (rpr/MIDI_DeleteEvt take 0))
	    (range (rpr/MIDI_CountEvts take))))

(define* (delete-event idx (take (-cur-take)))
  (rpr/MIDI_DeleteEvt take idx))

(define* (insert-note
	  ;; will insert a note in the cursor position
	  ;; with a duration of: length * grid-size
	  (length 1)
	  (pitch 60)
	  (velocity 100)
	  (selected? #f)
	  (muted? #f)
	  (channel 1)
	  (take (-cur-take)))
  (let ((start (rpr/MIDI_GetPPQPosFromProjTime
		take
		(rpr/GetCursorPosition)))
	(end (rpr/MIDI_GetPPQPosFromProjTime
	      take
	      (rpr.time/save-cursor-position
	       (rpr.time/move-cursor length)
	       (rpr/GetCursorPosition)))))
    
    (rpr/MIDI_InsertNote take selected? muted? start end channel pitch velocity))
  ;; the end
  )

(comment
 (insert-note)
 (insert-note :pitch 90)
 (insert-note :pitch 12 :length 2)
 (delete-all-events)

 
 (rpr/MIDI_CountEvts (-cur-take))
 (rpr/GetCursorPosition)
 
 (rpr/MIDI_GetPPQPosFromProjTime
  (-cur-take)
  (rpr/GetCursorPosition))

 (ns-doc rpr 'MIDI_InsertNote)
 "(MIDI_InsertNote p-media-item-take selected? muted? startppqpos endppqpos chan pitch vel &opt no-sort-in?)"
 
 (delete-event 0)

 (documentation range )
 (delete-all-events)
 )
