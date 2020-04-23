# frozen_string_literal: true

require './lib/user'
require 'spec_helper'

RSpec.describe User do
  it 'starts with no books in reading list' do
    user = User.new

    expect(user.reading_list.last).to eq nil
  end

  context 'after querying for books' do
    it 'can add a book to reading list' do
      user = User.new
      query = 'programming'
      books = user.search_books(query)

      user.add_book(books[0])

      expect(user.reading_list.last).to eq(books[0])
    end

    it 'if book is already in reading list, adding book does not duplicate it in the reading list' do
      user = User
      query = 'programming'
      user = User.new
      books = user.search_books(query)

      user.add_book(books[0])
      user.add_book(books[0])

      expect(user.reading_list.size).to eq(1)
      expect(user.reading_list[0]).to eq(books[0])
    end
  end

  context "can search for books with keyword(s) query" do
    it 'returns a list of 5 books' do
      user = User.new
      query = 'ruby programming'
      results = user.search_books(query)

      expect(results.count).to eq(5)
    end
  end
end
