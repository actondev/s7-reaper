(ns rpr.item
    :doc "Item related functionality"
    )

(define (start-end item)
  (let ((start (rpr/GetMediaItemInfo_Value item "D_POSITION"))
	(length (rpr/GetMediaItemInfo_Value item "D_LENGTH")))
    (list start (+ start length))))
