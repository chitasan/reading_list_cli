# frozen_string_literal: true

require './lib/filtered_books'
require 'spec_helper'

RSpec.describe FilteredBooks do
  context 'when searching books with a valid query and number of results' do
    it 'returns the number of results as requested' do
      books = FilteredBooks.new(query: 'programming', num_of_results: 5)
      results = books.get

      expect(results.count).to eq(5)
    end

    it 'return results with title, authors, and publisher info' do
      books = FilteredBooks.new(query: 'programming', num_of_results: 5)
      results = books.get

      expect(results[0]).to have_key(:title)
      expect(results[0]).to have_key(:authors)
      expect(results[0]).to have_key(:publisher)
    end
  end
end
