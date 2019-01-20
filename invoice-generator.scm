(load "data.scm")

(use-modules (sxml simple))

(define (personal-info)
  `(div (@ (style "display: inline-block; width: 80%;"))
    (h3 ,(assoc-ref data "name"))
    (div ,(assoc-ref data "address1"))
    (div ,(assoc-ref data "address2"))
    (div ,(string-append "Phone: " (assoc-ref data "phone")))))

(define (invoice-info)
  `(div (@ (style "display: inline-block;"))
    (h1 "INVOICE")
    (div ,(string-append "INVOICE #" (assoc-ref data "invoice-number")))

    (div ,(assoc-ref data "current-date"))))

(define (client-info)
  `(div (@ (style "padding-top: 100px"))
    (h3 "To:")
    (div ,(assoc-ref data "client-name"))
    (div ,(assoc-ref data "client-address1"))
    (div ,(assoc-ref data "client-address2"))))

(define (payment-info)
  `(div (@ (style "padding-top: 100px;"))
    (h3 "Payment by Wire Transfer to:")
    (div ,(string-append "Bank Name " (assoc-ref data "bank-name")))
    (div ,(string-append "Bank Routing Number " (assoc-ref data "routing-number")))
    (div ,(string-append "Account Number " (assoc-ref data "account-number")))))

(define (table-styling)
  `(style "table, th, td { border: 1px solid black; border-collapse: collapse; }"))

(define (invoice-table)
  `(div
    (@ (style "padding-top: 100px;"))
    (table
     (@ (style "width: 70%;"))
     (tr
      (th "Item")
      (th "Amount"))
     (tr
      (td ,(assoc-ref data "invoice-item"))
      (td ,(assoc-ref data "invoice-amount")))
     (tr
      (td (b "Total:"))
      (td ,(assoc-ref data "total-amount"))))))

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

(system "wkhtmltopdf temp.html test.pdf")
(system "rm -f temp.html")
