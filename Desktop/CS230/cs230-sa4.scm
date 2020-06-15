
(require racket/base)

(define (length items) 
  (if (null? items) 
      0 
      (+ 1 (length (cdr items)))))

(define (true-for-all-pairs? predicate sentence)
  (cond ((= (length sentence) 1) #t)
        ((predicate (car sentence) (car (cdr sentence)))
         (true-for-all-pairs? predicate (cdr sentence)))
        (else #f)))

(define make-adder
  (lambda (n)
    (lambda (x)
      (+ x n))))
(define add-5 (make-adder 5))
;(add-2 9)
(define compose
  (lambda ((f <function>) (g <function>))
    (lambda (x)
      (f (g x)))))



(define curry
  (lambda ((f <function>) (x <integer>))
    (lambda (y)
      (f x y))))
(define add-2 (curry + 2))
(define double (curry * 2))
(define triple (curry * 3))

(define map
  (lambda ((f <function>) (lst <list>))
    (cond ((null? lst) lst)
          (else (cons (f (car lst))
                      (map f (cdr lst)))))))
  