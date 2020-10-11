(ns rpr.midi
    :require ((rpr.time)
	      (stochastic.core :as stoch)
	      (aod.midi.core :as midi)
	      (aod.midi.scales :as scales)))
(ns-doc 'aod.midi.scales)
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

(define* (insert-intervals
	  intervals
	  (root 60))
  (rpr.time/save-cursor-position
   (for-each (lambda (x)
	       (insert-note :pitch (+ root x))
	       ;; advance
	       (rpr.time/move-cursor +1)
	       )
	     intervals)))

(define* (insert-markov-melody
	  (root (midi/note c 4))
	  (steps 8)
	  (scale scales/major)
	  )
  (let ((intervals (stoch/markov :init 0
				 :transitions
				 '(0 1 -1 3 -3 5 -5 7 -7 12 -12 12 -12)
				 :steps steps
				 :snap-fn (let ((snaps
						 (midi/add-sub-octave scale)))
					    (lambda (x)
					      (snap x snaps))))))
    (print "intervals" intervals)
    (insert-intervals intervals :root root)))

(comment
 (insert-intervals (range 12))
 (insert-note :pitch (midi/note c 4))
 (begin
   (delete-all-events)
   (rpr.time/with-grid
    1/7
    (insert-markov-melody
     :root (midi/note E 2)
     :scale scales/minor
     :steps 13
     )))
 )

;; TODO where should this belong? which namespace??
(define (snap val permitted)
  (let loop ((incd val)
	     (decd val))
    (cond ((member incd permitted) incd)
	  ((member decd permitted) decd)
	  (#t (loop (inc incd) (dec decd))))))

(comment
 (snap-octave+- 4)
 )

(comment

 (stoch/markov :init 0
	       :transitions
	       '(0 1 -1 3 -3 5 -5 7 -7 12 -12 12 -12)
	       :steps 8
	 :snap-fn (let ((snaps
			 (midi/add-sub-octave scales/major)))
		    (lambda (x)
		      (snap x snaps))))
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
