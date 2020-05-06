# frozen_string_literal: true

require './lib/books_processor'
require 'spec_helper'

RSpec.describe BooksProcessor do
  class FakeBooksApiWithResults
    def get_parsed_data
      File.read('lib/data_with_results.txt')
    end
  end

  class FakeBooksApiWithNoResults
    def get_parsed_data
      File.read('lib/data_with_no_results.txt')
    end
  end

  class FakeBooksApiMissingInfo
    def get_parsed_data
      File.read('lib/data_with_missing_info')
    end
  end

  context 'when searching for books with a query and number of results' do
    it 'return results with only title, authors, and publisher info' do
      query = 'programming'
      num_of_results = 5
      books_api = FakeBooksApiWithResults.new
      books = described_class.new(query: query, num_of_results: num_of_results, books_api: books_api)
      results = books.get

      results.each do |result|
        expect(result).to include(
          :title,
          :authors,
          :publisher
        )
      end
    end

    it 'returns a message when there are no results found' do
      query = 'adsfsadfasdfasfdsfsadfasdfsadfasdfsad'
      num_of_results = 5
      books_api = FakeBooksApiWithNoResults.new
      books = described_class.new(query: query, num_of_results: num_of_results, books_api: books_api)
      results = books.get

      expect(results).to eq(nil)
    end

    it 'returns results with nil for missing information' do
      query = 'bible'
      num_of_results = 5
      books_api = FakeBooksApiMissingInfo.new
      books = described_class.new(query: query, num_of_results: num_of_results, books_api: books_api)
      results = books.get
      
      expect(results.first[:publisher]).to be nil
    end
  end
end
