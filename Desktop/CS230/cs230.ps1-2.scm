(require racket/base) ;;This allows the type system to work.
(require (file "cs230-graphics.scm")) ;;Pull in the definitions for the drawing window and stuff. Assumes the file is in the same directory. 
(define side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1)))
          (side len/3 heading lvl-1)
          (side len/3 (- heading PI/3) lvl-1)
          (side len/3 (+ heading PI/3) lvl-1)
          (side len/3 heading lvl-1)))))
(define flip-side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1)))
          (flip-side len/3 (- heading PI/4) lvl-1)
          (flip-side (* 2 len/3) (+ heading PI/4) lvl-1)
          (flip-side len/3 (- heading PI/4) lvl-1)))))

(define snowflake:2
  (lambda ((length <real>) (level <integer>) (generator <function>))
    (generator length 0.0 level)
    (generator length (* 2 PI/3) level)
    (generator length (- (* 2 PI/3)) level)))


(define square-snowflake:2
  (lambda ((length <real>) (level <integer>) (generator <function>))
    (generator length 0.0 level)
    (generator length PI/2 level)
    (generator length PI level)
    (generator length (* -1 PI/2) level)))
;; Make the graphics window visible, and put the pen somewhere useful
(init-graphics 640 480)
(clear)
(moveto 100 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
