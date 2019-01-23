# invoice-generator

guile script used for generating invoices in pdf format. input to the script is lisp code.

# Install

```bash
apt install guile wkhtmltopdf
```

# Usage

Create `personal.scm` like this, it can be reused for other invoices:
```
(define personal
  '(("name" . "Shiba Inu")
    ("address1" . "420 Shibenobi Rd")
    ("address2" . "Dark Side, Moon 55555")
    ("phone" . "555-555-5555")
    ("bank-name" . "Chase")
    ("routing-number" . "3467543")
    ("account-number" . "123456789")))    
```

Make a directory example: `data`.

```bash
mkdir data
touch data/client.scm
touch data/invoice.scm
```

Then fill client in like this:

```
(define client
  '(("client-name" . "Annoying Client")
    ("client-address1" . "420 Cherry Dr, San Francisco")
    ("client-address2" . "CA 55555")))
```

Last but not least, fill in invoice like this:
```
(define (item date amount)
  (cons date amount))

(define items
  (list (item "January 1-15 2019" 1500.00)))

(define invoice-meta-data
  '(("invoice-number" . "1")
    ("current-date" . "1/16/2019")))
```

Now we can cleanly run the script:

```bash
guile -s invoice-generator.scm
```

You should see a file named `output.pdf` now.