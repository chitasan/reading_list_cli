# frozen_string_literal: true

require './lib/user'
require 'spec_helper'

RSpec.describe User do
  context 'reading list' do
    it 'starts with no books in reading list' do
      user = User.new

      expect(user.reading_list.empty?).to be true
    end

    it 'already has a book, adding book again does not duplicate it in the reading list' do
      user = User.new
      query = 'programming'
      num_of_results = 5
      books = user.search_books(query, num_of_results)

      user.add_book(books[0])
      user.add_book(books[0])

      expect(user.reading_list.size).to eq(1)
      expect(user.reading_list[0]).to eq(books[0])
    end
  end

  context "can search for books with valid keyword(s) query and num of results" do
    it 'returns a list of books by default' do
      user = User.new
      query = 'programming' 
      num_of_results = 5
      results = user.search_books("programming", num_of_results)

      expect(results.count).to eq(5)
    end
  end
end

