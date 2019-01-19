(load "data.scm")

(use-modules (sxml simple))

(define (personal-info)
  `(div
    (div ,(assoc-ref data "name"))
    (div ,(assoc-ref data "address1"))
    (div ,(assoc-ref data "address2"))
    (div ,(string-append "Phone: " (assoc-ref data "phone")))))

(define (invoice-info)
  `(div
    (div "INVOICE")
    (div ,(string-append "INVOICE #" (assoc-ref data "invoice-number")))

    (div ,(assoc-ref data "current-date"))))

(define (client-info)
  `(div
    (div ,(assoc-ref data "client-name"))
    (div ,(assoc-ref data "client-address1"))
    (div ,(assoc-ref data "client-address2"))))

(define (payment-info)
  `(div
    (div "Payment by Wire Transfer to:")
    (div ,(string-append "Bank Name " (assoc-ref data "bank-name")))
    (div ,(string-append "Bank Routing Number " (assoc-ref data "routing-number")))
    (div ,(string-append "Account Number " (assoc-ref data "account-number")))))

(define (invoice-table)
  `(div
    (div "Invoice Item")
    (div "Invoice Amount")
    (div ,(assoc-ref data "invoice-item"))
    (div ,(assoc-ref data "invoice-amount"))
    (div ,(assoc-ref data "total-amount"))))

(define (invoice-html)
  `(html
    (head (title "Invoice"))
    (body
     ,(personal-info)
     ,(invoice-info)
     ,(payment-info)
     ,(invoice-table))))

(call-with-output-file "temp.html"
  (lambda (port)
    (display "<!DOCTYPE html>" port)
    (newline port)
    (sxml->xml (invoice-html) port)
    (newline port)))

(system "wkhtmltopdf temp.html test.pdf")
(system "rm -f temp.html")
