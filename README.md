# invoice-generator

Ruby script used for generating invoices in pdf format. Input to the script is json data.

# Install

```bash
apt install ruby wkhtmltopdf
```

# Usage

Make a directory called `data`, we will put our json files there.
Then create the json files:
```bash
mkdir data
touch data/personal.json
touch data/client.json
touch data/invoice.json
```

Create `personal.json` like this, it can be reused for other invoices:
```javascript
{
    "name": "Foo Bar",
    "address1": "420 East Foo Street",
    "address2": "Dark Side, MN 43215",
    "phone": "123-321-1234",
    "routing-number": "123456789",
    "account-number": "123456789"
}
```

`client.json` like this:
```javascript
{
    "name": "Company Name",
    "address1": "Foobar Dr, Chicago",
    "address2": "IL 54034"
}
```

Lastly `invoice.json` like this:
```javascript
{
    "number": 1,
    "date": "4/20/20",
    "items": [
	{
	    "date": "4/18/20",
	    "info": "Stuff"
	    "hours": 2
	},
	{
	    "date": "4/19/20",
	    "info": "stuff"
	    "hours": 4
	},
	...
    ]
}
```

Now we can cleanly run the script:

```bash
ruby invoice_generator.rb
```

You should see a file named `output.pdf` now.