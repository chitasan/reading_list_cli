# frozen_string_literal: true

require 'faraday'
require './lib/user'

class BooksApp
  attr_reader :num_of_results, :prompt, :user

  def initialize(num_of_results: 5, user: User.new)
    @num_of_results = num_of_results
    @user = user
    @prompt = '>> '
  end

  def greeting
    puts "Welcome to Books. Your reading list is empty. Please search for books to add to it."
  end

  def start
    results = if search?
      query = get_query
      search_books(query)
    end
    prettify_list(results, "search results") if results != nil

    if results
      loop do
        case next_action
        when 'add'
          add_book(results)
        when 'search'
          start
          break
        when 'view'
          view_reading_list
        else
          puts "Not a valid input."
        end
      end
    end
  end

  def next_action
    puts "What would you like to do next?"
    puts "Add a book result to your reading list? Enter 'add'."
    puts "Start a new search for books? Enter 'search'."
    puts "View your reading list? Enter 'view'."
    print prompt
    $stdin.gets.to_s.strip.downcase
  end

  def view_reading_list
    if user.reading_list.empty?
      puts "Your reading list is currently empty."
    else
      prettify_list(user.reading_list, "reading list")
    end
  end

  def add_book(results)
    book = select_book(results) if add_book?
#refactor with index
    case book
    when 1
      user.add_book(results[0])
      puts "'#{results[0][:title]}' is added to your reading list."
    when 2
      user.add_book(results[1])
      puts "'#{results[1][:title]}' is added to your reading list."
    when 3
      user.add_book(results[2])
      puts "'#{results[2][:title]}' is added to your reading list."
    when 4
      user.add_book(results[3])
      puts "'#{results[3][:title]}' is added to your reading list."
    when 5
      user.add_book(results[4])
      puts "'#{results[4][:title]}' is added to your reading list."
    else
      puts "Not a valid input."
    end
  end

  def search_books(query)
    user.search_books(query, num_of_results)
  end


  def select_book(results)
    puts "Enter the respective Book #, above the Title, you want to add. For example: enter '1' for Result #: 1"
    print prompt
    $stdin.gets.to_i
  end

  def add_book?
    puts "Do you want to add a book from your search results to your reading list? ['yes'/'no']"
    print prompt

    while input = $stdin.gets.to_s.strip.downcase
      case input
      when 'yes'
        return true
        break
      when 'no' 
        return false
        break
      else
        puts "Invalid input. Please enter 'yes' or 'no'."
        print prompt
      end
    end
  end

  def search?
    puts "Do you want to search for books? ['yes'/'no']"
    print prompt

    while input = $stdin.gets.to_s.strip.downcase
      case input
      when 'yes'
        return true
        break
      when 'no' 
        puts 'See you again. Goodbye!'
        return false
        break
      else
        puts "Invalid input. Please enter 'yes' or 'no'."
        print prompt
      end
    end
  end

  def get_query
    puts "What keyword(s) do you want to search?"
    print prompt

    loop do
      input = $stdin.gets.to_s.strip.downcase
      return input
      break if input != ''
      puts "Keyword(s) cannot be blank. Please enter keyword(s)."
      print prompt
    end
  end

  def prettify_list(results, list_type)
    line = "....................."
    #make generic
    puts "#{line}\n"
    puts "***YOUR #{list_type.upcase}***"
    puts "#{line}\n"

    results.each_with_index do |book, index|
      title = book[:title]
      authors = book[:authors]
      publisher = book[:publisher]
      line = "....................."

      puts "Book #: #{index + 1}\nTitle: #{title}\nAuthor(s): #{authors.join(', ')}\nPublisher: #{publisher}\n#{line}"
    end
  end
end
