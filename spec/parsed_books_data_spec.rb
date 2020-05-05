# frozen_string_literal: true

require './lib/parsed_books_data'
require 'spec_helper'

RSpec.describe ParsedBooksData do
  context 'when searching for books with a query and number of results' do
    it 'return results with only title, authors, and publisher info' do
      books = described_class.new(query: 'programming', num_of_results: 5)
      results = books.get

      results.each do |result|
        expect(result).to include(
          :title,
          :authors,
          :publisher
        )
      end
    end
  end
end
