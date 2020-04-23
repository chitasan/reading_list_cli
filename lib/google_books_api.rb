# frozen_string_literal: true

require 'json'

class GoogleBooksApi
  def initialize(query, num_of_results)
    @query = query
    @num_of_results = num_of_results
  end

  def get_parsed_data
    response = connection.get
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def connection
    Faraday.new(url: 'https://www.googleapis.com/books/v1/volumes') do |faraday|
      faraday.params['key'] = ENV['GOOGLE_BOOKS_API_KEY']
      faraday.params['q'] = query
      faraday.params['maxResults'] = num_of_results
      faraday.adapter Faraday.default_adapter
    end
  end

  attr_reader :query, :num_of_results
end
