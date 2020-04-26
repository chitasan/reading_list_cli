# frozen_string_literal: true

require './lib/books_app'
require 'spec_helper'
require 'stringio'

RSpec.describe BooksApp do
  class FakeUser
    attr_reader :reading_list

    def initialize
      @reading_list = []
    end

    def add_book(book)
      reading_list << book
    end

    def search_books(query, num_of_results)
      [
        {
          :title=>"The Rust Programming Language",
          :authors=>["Steve Klabnik", "Carol Nichols"],
          :publisher=>"No Starch Press"
        },
        {
          :title=>"The C++ Programming Language",
          :authors=>["Bjarne Stroustrup"],
          :publisher=>"Addison-Wesley"
        },
        {
          :title=>"The Go Programming Language",
          :authors=>["Alan A. A. Donovan", "Brian W. Kernighan"],
          :publisher=>"Addison-Wesley Professional"
        },
        {
          :title=>"Computer Programming",
          :authors=>["J. Maynard"],
          :publisher=>"Elsevier"
        },
        {
          :title=>"A Complete Guide to Programming in C++",
          :authors=>["Ulla Kirch-Prinz", "Peter Prinz"],
          :publisher=>"Jones & Bartlett Learning"
        }
      ]
    end
  end

  context 'when a user first uses the app' do
    it 'gets greeted' do
      user = FakeUser.new
      app = BooksApp.new

      expect { app.greeting }.to output("Welcome to Books. Your reading list is empty. Please search for books to add to it.\n").to_stdout
    end
  end

  context 'when a user says no to search for books' do 
    it 'says bye and exits the program' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      $stdin = StringIO.new("no\n") 
    
      expect { app.start }.to output(
        "Do you want to search for books? ['yes'/'no']\n" + 
        ">> See you again. Goodbye!\n"
      ).to_stdout
    end
  end

  context 'when a user says yes to search for books' do
    it 'asks for keywords to search' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      $stdin = StringIO.new("programming\n") 

      expect { app.get_query }.to output(
        "What keyword(s) do you want to search?\n" +
        ">> "
      ).to_stdout
    end

    it 'returns search results in a numbered list' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      results = app.search_books('programming')
      list_type = "search results"
      app.prettify_list(results, list_type)
  
      expect{ app.prettify_list(results, list_type) }.to output(
        ".....................\n" +
        "***YOUR SEARCH RESULTS***\n" + 
        ".....................\n" +
        "Book #: 1\nTitle: The Rust Programming Language\nAuthor(s): Steve Klabnik, Carol Nichols\nPublisher: No Starch Press\n" +
        ".....................\n" +
        "Book #: 2\nTitle: The C++ Programming Language\nAuthor(s): Bjarne Stroustrup\nPublisher: Addison-Wesley\n" +
        ".....................\n" +
        "Book #: 3\nTitle: The Go Programming Language\nAuthor(s): Alan A. A. Donovan, Brian W. Kernighan\nPublisher: Addison-Wesley Professional\n" +
        ".....................\n" +
        "Book #: 4\nTitle: Computer Programming\nAuthor(s): J. Maynard\nPublisher: Elsevier\n" +
        ".....................\n" +
        "Book #: 5\nTitle: A Complete Guide to Programming in C++\nAuthor(s): Ulla Kirch-Prinz, Peter Prinz\nPublisher: Jones & Bartlett Learning\n" +
        ".....................\n" 
      ).to_stdout
    end

    it 'prompts user to choose next step' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      results = app.search_books("programming")
      $stdin = StringIO.new("add\n")
      
      expect { app.next_action }.to output(
        "What would you like to do next?\n" + 
        "Add a book result to your reading list? Enter 'add'.\n" +
        "Start a new search for books? Enter 'search'.\n" + 
        "View your reading list? Enter 'view'.\n" + 
        ">> "
      ).to_stdout
    end

    it 'prompts user again if user types in invalid next step choice' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      results = app.search_books("programming")
      app.view_reading_list
      $stdin = StringIO.new("delete\n")
      
      expect { app.next_action }.to output(
        "What would you like to do next?\n" + 
        "Add a book result to your reading list? Enter 'add'.\n" +
        "Start a new search for books? Enter 'search'.\n" + 
        "View your reading list? Enter 'view'.\n" + 
        ">> "
      ).to_stdout
    end
    
    it 'lets user select a book from the search results to add to reading list and returns a confirmation message' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      results = app.search_books("programming")
      $stdin = StringIO.new("yes\n1\n")
      
      expect { app.add_book(results) }.to output(
        "Do you want to add a book from your search results to your reading list? ['yes'/'no']\n" +
        ">> Enter the respective Book #, above the Title, you want to add. For example: enter '1' for Result #: 1\n" +
        ">> 'The Rust Programming Language' is added to your reading list.\n"
      ).to_stdout
    end
  end

  context 'a user can view reading list by entering yes' do
    it 'returns a message if reading list empty' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      $stdin = StringIO.new("yes\n")
      
      expect { app.view_reading_list }.to output("Your reading list is currently empty.\n").to_stdout
    end

    it 'returns a numbered reading list if reading list is not empty' do
      user = FakeUser.new
      app = BooksApp.new(user: user)
      results = app.search_books("programming")
      $stdin = StringIO.new("yes\n1\n")
      app.add_book(results)
      $stdin = StringIO.new("yes\n")

      expect { app.view_reading_list }.to output(
        ".....................\n" +
        "***YOUR READING LIST***\n" + 
        ".....................\n" +
        "Book #: 1\nTitle: The Rust Programming Language\nAuthor(s): Steve Klabnik, Carol Nichols\nPublisher: No Starch Press\n" +
        ".....................\n"
      ).to_stdout
    end
  end
end
