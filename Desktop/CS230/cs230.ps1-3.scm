(require racket/base) ;;This allows the type system to work.
(require (file "cs230-graphics.scm")) ;;Pull in the definitions for the drawing window and stuff. Assumes the file is in the same directory. 
(define snowflake:2
  (lambda ((length <real>) (level <integer>) (generator <function>))
    (generator length 0.0 level)
    (generator length (* 2 PI/3) level)
    (generator length (- (* 2 PI/3)) level)))


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
(define snowflake-inv
  (lambda ((length <real>) (level <integer>) (generator <function>) (inverter <procedure>))
    (generator length 0.0 level inverter)
    (generator length (* 2 PI/3) level inverter)
    (generator length (- (* 2 PI/3)) level inverter)))

(define side-inv
  (lambda ((length <real>) (heading <real>) (level <integer>) (inverter <procedure>))
    (cond ((zero? level)
           (drawto heading length))

          ((positive? (inverter level))
           (let ((len/3 (/ length 3))
                 (lvl-1 (- level 1)))
             (side-inv len/3 heading lvl-1 inverter)
             (side-inv len/3 (- heading PI/3) lvl-1 inverter)
             (side-inv len/3 (+ heading PI/3) lvl-1 inverter)
             (side-inv len/3 heading lvl-1 inverter)))

          ((negative? (inverter level))
           (let ((len/3 (/ length 3))
                 (lvl-1 (- level 1)))
             (side-inv len/3 heading lvl-1 inverter)
             (side-inv len/3 (+ heading PI/3) lvl-1 inverter)
             (side-inv len/3 (- heading PI/3) lvl-1 inverter)
             (side-inv len/3 heading lvl-1 inverter))))))


                  
                
                
             
;; Make the graphics window visible, and put the pen somewhere useful
(init-graphics 640 480)
(clear)
(moveto 100 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
