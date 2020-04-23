# frozen_string_literal: true

require './lib/user'
require 'spec_helper'

RSpec.describe User do
  context "a user's reading list" do
    it 'can be added to' do
      user = User.new
      book = {
        title: 'title',
        authors: 'author',
        publisher: 'publisher'
      }

      user.add_book(book)

      expect(user.reading_list.last).to eq(book)
    end

    context 'can be viewed' do
      it 'returns a list of books if reading list is no empty' do
        user = User.new
        book = {
          title: 'title',
          authors: 'author',
          publisher: 'publisher'
        }
        user.add_book(book)

        expect(user.reading_list).to eq([book]) 
        expect(user.reading_list.size).to eq(1)
      end

      it 'returns an empty array if empty' do
        user = User.new

        expect(user.reading_list).to eq([])
      end
    end
  end

  context 'when a user searches for books' do
    it 'returns a list of 5 books' do
      user = User.new
      keywords = 'programming'
      results = user.search_books(keywords)
    
      expect(results.count).to eq(5)
    end
  end
end
