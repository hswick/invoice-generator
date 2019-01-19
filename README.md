# invoice-generator

guile script used for generating invoices in pdf format. input to the script is lisp code.

# Install

```bash
apt install guile wkhtmltopdf
```

# Usage

Create `data.scm` with this content:
```
(define data
  '(("name" . "Shiba Inu")
    ("address1" . "420 Shibenobi Rd")
    ("address2" . "Dark Side, Moon 55555")
    ("phone" . "555-555-5555")
    ("client-name" . "Client Name")
    ("client-address1" . "4343 Goobar Dr.")
    ("client-address2" . "CA 56732")
    ("bank-name" . "Chase")
    ("routing-number" . "3467543")
    ("account-number" . "123456789")
    
    ;invoice specific
    ("invoice-number" . "2")
    ("current-date" . "JANUARY 1, 2019")
    ("invoice-item" . "December 1-31 2018")
    ("invoice-amount" . "$200.00")
    ("total-amount" . "$200.00")))
```

```bash
guile -s invoice-generator.scm
```