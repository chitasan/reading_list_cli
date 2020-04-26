# frozen_string_literal: true

require './lib/books_api'
require 'spec_helper'

RSpec.describe BooksApi do
  context 'when sending get request to Books API with a valid API key' do
    it 'returns requested data for a query and num of results returned' do
      query = 'programming'
      results = 5

      conn = described_class.new(query: query, num_of_results: results)
      response = conn.get_parsed_data

      expect(response).to be_a(Hash)
      expect(response).to include(
        :kind,
        :totalItems,
        :items
      )
      expect(response[:items].count).to eq(5)
    end

    it 'returns requested data for a different query and num of results returned' do
      query = 'baking'
      results = 6 

      conn = described_class.new(query: query, num_of_results: results)
      response = conn.get_parsed_data

      expect(response).to be_a(Hash)
      expect(response).to include(
        :kind,
        :totalItems,
        :items
      )
      expect(response[:items].count).to eq(6)
    end 
  end
end
