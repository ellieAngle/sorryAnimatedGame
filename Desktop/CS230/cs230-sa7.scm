(require racket/base)

(define deep-reverse
  (lambda ((lst <list>))
    (cond ((null? lst) lst)  ;O(1) --> this cond = O(1)
          ((pair? (car lst))  ;O(1)
            (let ((new (deep-reverse (car lst))))  ;O(n)
              (append  ;O(n)
               (deep-reverse (cdr lst))  ;O(n)
               (list new))))
          ; this cond = O(n^2)
          (else
           (append ;O(n)
            (deep-reverse (cdr lst)) ;O(n)
            (list (car lst)))))))
          ; this else = O(n^2)

#|
The runtime for deep-reverse is O(n^2)

- For the second cond, ((pair? (car lst))... ), deep-reverse (cdr lst) runs n times
until it reaches an empty list, at which point, append evaluates n times for each time
reverse called it. This makes this cond have a runtime of O(n^2) It is worth mentioning that
(let ((new (deep-reverse (car lst)))) also has a runtime of O(n), however this is simply
added to the O(n^2) runtime and is made irrelevant to our runtime analysis as it is of
a smaller order (power)

- for the else statement, the runtime is also O(n^2), as (deep-reverse (cdr lst)) runs n
times, and then once it has finished running n times, append then evaluates n times. Creating
n*n = O(n^2)

Because this is a cond/else combination, the runtime for the entire function is O(n^2), not
O(n^4) or something else. Each time the function recurses, it will go through either the cond
branch or the else branch (never both). Thus making our runtime O(n^2)

TEST CASES:
> (deep-reverse '())
()
> (deep-reverse '(1))
(1)
> (deep-reverse '(1 (2 3) 4 5))
(5 4 (3 2) 1)
> (deep-reverse '(1 (2 3) (4 (5 6) 7) (8 9 (10 11 (12)))))
((((12) 11 10) 9 8) (7 (6 5) 4) (3 2) 1)

|#
