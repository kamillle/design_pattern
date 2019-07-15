# public interface Aggregate {
#     puclic abstract 戻り値の型 メソッド名
#     public abstract Interator iterator();
# }
module Aggregate
  def iterator
    # Interator Classのオブジェクトが返るように実装する
    #
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

module Iterator
  def has_next?
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end

  def next
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

class Book
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class BookShelf
  include Aggregate

  attr_accessor :maxsize

  def initialize(maxsize)
    @books = []
    @maxsize = maxsize
    @last = 0
  end

  def get_book_at(index)
    @books[index]
  end

  def append_book(book)
    @books[@last] = book

    @last += 1

    nil
  end

  def get_length
    @last
  end

  # Aggregate moduleで定義したインターフェイスを実装する
  # BookShelの数え上げ等の責務をBookShelfIteratorに委譲する
  def iterator
    BookShelfIterator.new(self)
  end
end

class BookShelfIterator
  include Iterator

  def initialize(book_shelf)
    @book_shelf = book_shelf
    @index = 0
  end

  def has_next?
    if @index < @book_shelf.get_length
      return true
    else
      return false
    end
  end

  def next
    book = @book_shelf.get_book_at(@index)
    @index += 1

    book
  end
end

class Main
  def self.execute(args)
    book_shelf = BookShelf.new(4)
    book_shelf.append_book(Book.new("Around the World in 80 days"))
    book_shelf.append_book(Book.new("Bible"))
    book_shelf.append_book(Book.new("Cinderella"))
    book_shelf.append_book(Book.new("Daddy-Long-Legs"))

    iterator = book_shelf.iterator

    while iterator.has_next?
      book = iterator.next
      p book.name
    end
  end
end

Main.execute(ARGV[0])
