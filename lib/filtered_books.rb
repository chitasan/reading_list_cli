# frozen_string_literal :true

require './lib/google_books_api'
require 'json'

class FilteredBooks
  def initialize(query:, num_of_results:)
    @query = query
    @num_of_results = num_of_results
  end

  def get 
    books = books_data[:items]
    
    books.map do |book|
      {
        title: book[:volumeInfo][:title],
        authors: book[:volumeInfo][:title],
        publisher: book[:volumeInfo][:publisher]
      }
    end
  end

  private

  def books_data 
    response = books_query.get
  end

  def books_query
    GoogleBooksApi.new(query: query, num_of_results: num_of_results)
  end

  attr_reader :query, :num_of_results
end
