#lang racket

;OPEN SOURCE CSV PROCESSING LIBRARY



(require racket/system)

;load raw string data from .csv file online
(define (load-raw-csv-data url)
  (let 
      ( [result (with-output-to-string (lambda () (system (~a "curl -s " url)))) ] )
    (substring result 0 (- (string-length result) 1))
    )  
  )


;convert csv string into matrix
(define (csv->matrix csv-string)
  (map (lambda (x) (string-split x ","))
       (string-split csv-string "\n"))
  )

;acces point on csv matrix 
(define (access-value csv-matrix row column)
  (list-ref (list-ref csv-matrix row) column)
  )

;map function on every data point within matrix
(define (matrix-map function csv-matrix)
  (foldr (lambda (x y) (cons (map function x) y)) empty csv-matrix)
  
  )

;list subset function 
(define (subset my-list start end)
  (if (= start end) empty
      (cons (list-ref my-list start) (subset my-list (+ start 1) end)))
  
  )

;subset matrix of another matrix
(define (matrix-subset csv-matrix row-start row-end column-start column-end)
  
  (subset (subset csv-matrix row-start row-end) column-start column-end)
  
  )


;combines multiple columns withs some function

(define (operate-columns function column-1 column-2)
  
  (foldr (lambda (x y z) (cons (function x y) z)) empty column-1 column-2)
  
  )