(ns rpr.tracks
    :require ((rpr)))

(define cmd rpr/Main_OnCommand)

(define (select-all)
  (cmd 40296))

(comment
 (rpr/Main_OnCommand 40296)
 (select-all)
 ((rpr 'Main_OnCommand) 40005)
 )
