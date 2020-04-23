# frozen_string_literal: true

require './lib/filtered_books'
require './lib/google_books_api'

class User
  attr_reader :reading_list, :num_of_results

  def initialize
    @reading_list = []
    @num_of_results = 5
  end

  def add_book(book)
    reading_list << book
  end

  def search_books(keywords)
    search_results = FilteredBooks.new(query: keywords, num_of_results: num_of_results)
    search_results.get
  end
end
