(require racket/base)
#|
Part A:
What is the name of your professor (for this class, CS 230)?
     Professor Bruce Donald

Where did they get their Ph.D.?
     He got his Ph.D. from MIT

Briefly, what is the focus or topic of their research? (One sentence will suffice).
     His research is focused on computational biology, and his lab is determining the
     three-dimensional (3D) structures of proteins involved in human disease, and making
     drug-like molecules to treat these diseases

Briefly describe one finding, discovery, or result from their research laboratory. (One sentence will suffice; no more than 3 sentences).
     In “Protein Design by Algorithm,” Donald (alongside Mark A. Hallen) investigated and
     discovered the potential impact of often overlooked or untaught (in CS classes)
     algorithms on individual, community, and global health

|#

;Part 2 - tail recursive version of multiply from SA1
(define multiply:2
  (lambda ((a <number>) (b <integer>))
    (letrec ((iter
              (lambda (c result)
                (if (zero? c)
                    result
                    (if (negative? c)
                        (iter (+ c 1)
                              (+ result a))
                    (iter (- c 1)
                          (+ result a)))))))
        (iter b 0))))