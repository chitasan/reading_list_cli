# frozen_string_literal: true

require './lib/google_books_api'
require 'spec_helper'
require 'faraday'

RSpec.describe GoogleBooksApi do
  context 'when requesting connection from Google Books API with valid API key' do
    it 'successfully connects' do
      api_key = ENV['GOOGLE_BOOKS_API_KEY']
      query = 'programming'
      results = 5

      conn = Faraday.new('https://www.googleapis.com/books/v1/volumes') do |faraday|
        faraday.params['key'] = api_key
        faraday.params['q'] = query
        faraday.params['maxResults'] = results
        faraday.adapter Faraday.default_adapter
      end

      response = conn.get

      expect(response.status).to eq(200)
    end
  end

  context 'when requesting connection from Google Books API with an invalid API key' do
    it 'does not connect' do
      api_key = 'invalid_key'
      query = 'programming'
      results = 5

      conn = Faraday.new('https://www.googleapis.com/books/v1/volumes') do |faraday|
        faraday.params['key'] = api_key
        faraday.params['q'] = query
        faraday.params['maxResults'] = results
        faraday.adapter Faraday.default_adapter
      end

      response = conn.get

      expect(response.status).to eq(400)
    end
  end

  context 'when requesting connection from Google Books API with no API key' do
    it 'does not connect' do
      api_key = ''
      query = 'programming'
      results = 5

      conn = Faraday.new('https://www.googleapis.com/books/v1/volumes') do |faraday|
        faraday.params['key'] = api_key
        faraday.params['q'] = query
        faraday.params['maxResults'] = results
        faraday.adapter Faraday.default_adapter
      end

      response = conn.get

      expect(response.status).to eq(400)
    end
  end
end
