(require racket/base)

(define append 
  (lambda ((l1 <list>) (l2 <list>))
    (if (null? l1) 
        l2
        (cons (head l1) (append (tail l1) l2)))))

;; simple recursive
(define reverse:1
  (lambda ((lst <list>))
    (if (null? lst)  ;O(1)
        lst
        (append       ;O(n)
         (reverse:1 (cdr lst)) ;O(n)
         (list (car lst))))))
#|
The runtime for reverse:1 is O(n^2)
This is because when evaluating, reverse evaluates n times (the length of lst)
until it reaches an empty list. Then, having called append n times, append now evaluates
n times, until it goes from:
(append (append ... (append (append {} nth element) n-1st element) ... ) 2nd element) 1st element)
to: (nth n-1st ... 2nd 1st)
This means the runtime of reverse:1 = O(n * n) which is O(n^2)

TEST CASES:
>(reverse:1 '())
()
> (reverse '(1))
(1)
> (reverse:1 '(1 2 3 4 5))
(5 4 3 2 1)
> (reverse:1 '(1 (2 3) 4 5))
(5 4 (2 3) 1)

|#

;;------------------------------------------------------------------------------------------------;;
;; tail recursive
(define reverse:2
  (lambda ((lst <list>))
    (letrec ((iter
              (lambda ((cur <list>) (l <list>))
                (cond ((null? l) l) ;O(1)
                      ((null? (cdr l)) (cons (car l) cur)) ;O(1)
                      (else
                       (let ((cur (cons (car l) cur))) ;O(1)
                         (iter cur (cdr l))))))))   ;O(n)   
              (iter '() lst)))) ;O(n)
#|
the runtime for reverse:2 is O(n). Reverse:2 calls iter --> this function call is O(1)
thus the runtime for reverse:2 is the runtime for iter. Iter's runtime is O(n), which
comes entirely from the recursive call to itself in '(iter cur (cdr l))...)'. Each update
for cur is O(1), as it simply uses cons, an O(1) built-in. All the other function within
iter (and thus within reverse:2) have a runtime of O(1).
Therefor the runtime for reverse:2 is O(n)

TEST CASES:
> (reverse:2 '())
()
> (reverse:2 '(1))
(1)
> (reverse:2 '(1 2 3 4 5))
(5 4 3 2 1)
> (reverse:2 '(1 (2 3) 4 5))
(5 4 (2 3) 1)
|#
    