;;; Go to Language, Choose Language, Other Languages, Swindle, Full Swindle
;;; This may have to be done in cs230-graphics.scm as well
;;; cs230.ps1.scm


(require racket/base) ;;This allows the type system to work.
(require (file "cs230-graphics.scm")) ;;Pull in the definitions for the drawing window and stuff. Assumes the file is in the same directory. 

;; Here are the procedures you will modify in the problem set

;;given code
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

(define snowflake:0
  (lambda ((length <real>) (level <integer>))
    (side length 0.0 level)
    (side length (* 2 PI/3) level)
    (side length (- (* 2 PI/3)) level)))

;; problem 1:
(define flip-side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1)))
          (flip-side len/3 (- heading PI/4) lvl-1)
          (flip-side (* 2 len/3) (+ heading PI/4) lvl-1)
          (flip-side len/3 (- heading PI/4) lvl-1)))))

(define square-snowflake:1
  (lambda ((length <real>) (level <integer>))
    (flip-side length 0.0 level)
    (flip-side length PI/2 level)
    (flip-side length PI level)
    (flip-side length (* -1 PI/2) level)))


;;problem 2:
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

;;problem 3:
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

(define snowflake-inv
  (lambda ((length <real>) (level <integer>) (generator <function>) (inverter <procedure>))
    (generator length 0.0 level inverter)
    (generator length (* 2 PI/3) level inverter)
    (generator length (- (* 2 PI/3)) level inverter)))

;;problem 4:
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

;; Make the graphics window visible, and put the pen somewhere useful
(init-graphics 640 480)
(clear)
(moveto 100 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
PROBLEM 1 test cases:
(square-snowflake:1 150 3)

PROBLEM 2 test cases:
;; van Koch initiator with van Koch generator
(snowflake:2 200 3 side)

;; van Koch initiator with flip-side generator
(snowflake:2 150 3 flip-side)

;; square initiator with van Koch generator
(square-snowflake:2 200 3 side)

;; square initiator with flip-side generator
(square-snowflake:2 150 3 flip-side)

PROBLEM 3 test cases:
(snowflake-inv 150 3 side-inv
               (lambda ((level <integer>)) 
	         (if (odd? level) 1 -1)))

(snowflake-inv 150 3 side-inv
               (lambda ((level <integer>)) 
	         (if (even? level) 1 -1)))

PROBLEM 4 test cases:
(snowflake-length 100.0 3 side-length 
                  (lambda ((level <integer>)) 1))
|#

