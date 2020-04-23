# frozen_string_literal: true

require './lib/filtered_books'
require './lib/google_books_api'

class User
  attr_reader :reading_list

  def initialize
    @reading_list = []
    @num_of_results = 5
  end

  def add_book(book)
    reading_list.push(book) unless reading_list.include?(book)
  end

  def search_books(query)
    filtered_books = FilteredBooks.new(query, num_of_results)
    search_results = filtered_books.get
  end

  private

  attr_reader :num_of_results
end
