# frozen_string_literal :true

require './lib/google_books_api'

class FilteredBooks
  def initialize(query, num_of_results)
    @query = query
    @num_of_results = num_of_results
    @books_api = GoogleBooksApi.new(query, num_of_results)
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
    books_api.get_parsed_data
  end

  attr_reader :query, :num_of_results, :books_api
end
