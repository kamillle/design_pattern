class Aggregate
  def iterator
  end
end

class Iterator
  def has_next?
  end

  def next
  end
end

class Book
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class BookShelf
  attr_accessor :books, :maxsize, :last

  def initialize(maxsize)
    @books = []
    @maxsize = maxsize
    @last = 0
  end

  def get_book_at(index)
    books[index]
  end

  def append_book(book)
    books[last] = book

    self.last += 1
  end

  def get_length
    last
  end

  def iterator
    BookShelfIterator.new(self)
  end
end

class BookShelfIterator
  attr_accessor :book_shelf, :index

  def initialize(book_shelf)
    @book_shelf = book_shelf
    @index = 0
  end

  def has_next?
    if self.index < book_shelf.get_length
      return true
    else
      return false
    end
  end

  def next
    book = book_shelf.get_book_at(index)
    self.index += 1

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

    it = book_shelf.iterator

    while it.has_next?
      book = it.next
      p book.name
    end
  end
end

Main.execute(ARGV[0])
