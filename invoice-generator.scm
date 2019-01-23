(define base "data/")

(load "personal.scm")
(load (string-append base "invoice.scm"))
(load (string-append base "client.scm"))

(use-modules (sxml simple))

(define (personal-info)
  `(div (@ (style "display: inline-block; width: 80%;"))
    (h3 ,(assoc-ref personal "name"))
    (div ,(assoc-ref personal "address1"))
    (div ,(assoc-ref personal "address2"))
    (div ,(string-append "Phone: " (assoc-ref personal "phone")))))

(define (invoice-info)
  `(div (@ (style "display: inline-block;"))
    (h1 "INVOICE")
    (div ,(string-append "INVOICE #" (assoc-ref invoice-meta-data "invoice-number")))
    (div ,(assoc-ref invoice-info "current-date"))))

(define (client-info)
  `(div (@ (style "padding-top: 100px"))
    (h3 "To:")
    (div ,(assoc-ref client "client-name"))
    (div ,(assoc-ref client "client-address1"))
    (div ,(assoc-ref client "client-address2"))))

(define (payment-info)
  `(div (@ (style "padding-top: 100px;"))
    (h3 "Payment by Wire Transfer to:")
    (div ,(string-append "Bank Name: " (assoc-ref personal "bank-name")))
    (div ,(string-append "Bank Routing Number: " (assoc-ref personal "routing-number")))
    (div ,(string-append "Account Number: " (assoc-ref personal "account-number")))))

(define (table-styling)
  `(style "table, th, td { border: 1px solid black; border-collapse: collapse; }"))

(define (invoice-items)
  (map
   (lambda (item)
     `(tr
       (td ,(car item))
       (td ,(cdr item))))
   items))

(define (calc-total)
  (apply + (map cdr items)))

(define (invoice-table)
  `(div
    (@ (style "padding-top: 100px;"))
    (table
     (@ (style "width: 70%;"))
     (tr
      (th "Item")
      (th "Amount ($)"))
     ,(invoice-items)
     (tr
      (td (b "Total:"))
      (td ,(calc-total))))))

(define (invoice-html)
  `(html
    (head (title "Invoice"))
    (body
     ,(personal-info)
     ,(invoice-info)
     ,(client-info)
     ,(payment-info)
     ,(table-styling)
     ,(invoice-table))))

(call-with-output-file "temp.html"
  (lambda (port)
    (display "<!DOCTYPE html>" port)
    (newline port)
    (sxml->xml (invoice-html) port)
    (newline port)))

(system "wkhtmltopdf temp.html output.pdf")
(system "rm -f temp.html")
