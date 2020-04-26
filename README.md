# Reading List CLI
This is a command line application that allows a user to search for books, add search results to a reading list, and view the reading list. The search function uses  [Google Books API](https://developers.google.com/books) to return results.

## Setup & Installation
```
$ git clone https://github.com/chitasan/reading_list_cli
```
```
$ bundle install 
```

## Testing
Set up Environment Variables by signing up for the API Key: [Google Books API](https://developers.google.com/books/docs/v1/getting_started)
```
$ export GOOGLE_BOOKS_API_KEY=your_api_key_here
```
To test, run: 
```
$ rspec
```

## To Run the App
```
$ ruby books_app_runner.rb
```

## The App Design
`BooksApi`connects to to an external service, in this case, Google Books API, requests data, and returns parsed data.

`FilteredBooks` gets only the necessary data from the parsed data. It returns a list of book results with title, author(s), and publisher information for each book, and filters everything else out.

`User` has an empty reading list, and ability to add to reading list and search for books.

`BooksApp` includes all output to and input from the user so that it can get the query information to search books, as well as any actions the user may want to take after a search (search for books, add to reading list, view reading list). 

## Built With
- ruby 2.6.3
- RSpec
