require './lib/books_app'
require 'faraday'

app = BooksApp.new
app.greeting
app.start

