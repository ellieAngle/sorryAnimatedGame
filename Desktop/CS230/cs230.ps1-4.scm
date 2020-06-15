(require racket/base) ;;This allows the type system to work.
(require (file "cs230-graphics.scm")) ;;Pull in the definitions for the drawing window and stuff. Assumes the file is in the same directory. 

(define side-length
  (lambda ((length <real>) (heading <real>) (level <integer>) (inverter <procedure>))
    (cond ((zero? level)
           (+ length 0))

          ((positive? (inverter level))
           (let ((len/3 (/ length 3))
                 (lvl-1 (- level 1)))
             (+
              (side-length len/3 heading lvl-1 inverter)
              (side-length len/3 (- heading PI/3) lvl-1 inverter)
              (side-length len/3 (+ heading PI/3) lvl-1 inverter)
              (side-length len/3 heading lvl-1 inverter))))

          ((negative? (inverter level))
           (let ((len/3 (/ length 3))
                 (lvl-1 (- level 1)))
             (+
              (side-length len/3 heading lvl-1 inverter)
              (side-length len/3 (+ heading PI/3) lvl-1 inverter)
              (side-length len/3 (- heading PI/3) lvl-1 inverter)
              (side-length len/3 heading lvl-1 inverter)))))))


(define snowflake-length
  (lambda ((length <real>) (level <integer>) (generator <function>) (inverter <procedure>))
    (* 3 (generator length 0.0 level inverter))))