require 'erb'
require 'json'

template = %q{
<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <div style='display: inline-block; width: 80%;' class='personal-info'>
      <h3><%= personal["name"] %></h3>
      <div><%= personal["address1"] %></div>
      <div><%= personal["address2"] %></div>
      <div><%= personal["phone"] %></div>
    </div>
    <style>
      table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
      }
    </style>
    <div style='display: inline-block;' class='invoice-info'>
      <h1> INVOICE </h1>
      <div> INVOICE # <%= invoice["number"] %></div>
      <div> <%= invoice["date"] %></div>
    </div>
    <div style='padding-top: 100px' class='client-info'>
      <h3> To: </h3>
      <div> <%= client["name"] %></div>
      <div> <%= client["address1"] %></div>
      <div> <%= client["address2"] %></div>
    </div>
    <div style='padding-top: 100px' class='payment-info'>
      <h3> Payment by Wire Transfer to: </h3>
      <div> Bank Name: <%= personal["bank-name"] %> </div>
      <div> Bank Routing Number: <%= personal["routing-number"] %></div>
      <div> Account Number: <%= personal["account-number"] %></div>
    </div>
    <div>
      <table style='width: 70%;'>
        <tr>
          <th> Date </th>
          <th> Item </th>
          <th> Hours </th>
        </tr>
        <% invoice["items"].each do |item| %>
          <tr>
            <td> <%= item["date"] %></td>
            <td> <%= item["info"] %></td>
            <td> <%= item["hours"] %></td>
          </tr>
        <% end %>
        <tr>
          <td><b>Total Hours:</b></td>
          <td></td>
          <td><%= invoice["items"].sum {|x| x["hours"] } %></td>
        </tr>
      </table>
    </div>
  </body>
</html>
}.gsub(/^ /, '')

# Init template
rhtml = ERB.new(template)

# Load state
@base = "data/"

def load_json(filename)
  JSON.parse(IO.read(@base + filename))
end

personal = load_json("personal.json")
invoice = load_json("invoice.json")
client = load_json("client.json")

# Render
IO.write("temp.html", rhtml.result)
system("wkhtmltopdf temp.html output.pdf")
system("rm -f temp.html")
