# frozen_string_literal: true

require './lib/filtered_books'

class User
  attr_reader :reading_list

  def initialize
    @reading_list = []
  end

  def add_book(book)
    reading_list.push(book) unless reading_list.include?(book)
  end

  def search_books(query, num_of_results)
    filtered_books = FilteredBooks.new(query: query, num_of_results: num_of_results)
    search_results = filtered_books.get
  end
end
