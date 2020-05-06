# frozen_string_literal :true

require './lib/books_api'

class BooksProcessor
  def initialize(query:, num_of_results:, books_api:)
    @query = query
    @num_of_results = num_of_results
    @books_api = BooksApi.new(query: query, num_of_results: num_of_results)
  end

  def get
    if books_data[:totalItems] == 0
      nil
    else
      books = books_data[:items]
      books.map do |book|
        { 
          title: book[:volumeInfo][:title],
          authors: author(book),
          publisher: book[:volumeInfo][:publisher]
        }
      end
    end
  end

  private

  def books_data 
    books_api.get_parsed_data
  end

  def publisher(book)
    if book[:volumeInfo].key?(:publisher) == false
      nil
    else
      book[:volumeInfo][:publisher]
    end
  end

  def author(book)
    if book[:volumeInfo].key?(:authors) == false
      nil
    else
      book[:volumeInfo][:authors]
    end
  end

  attr_reader :query, :num_of_results, :books_api
end
