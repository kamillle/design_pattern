下記のように先に適切なmoduleで適切なインターフェイスを定義しておくこと(抽象クラスを用意する)で、複数の開発者で開発を進める場合に実装レベルでルールが作れる。

- メソッド名を統一し、ロジックを共通化し、大体何の処理をしているか把握しやすくなる
- 共通の処理をいちいち全てのクラスに書き込む必要がなくなり、個別の処理も追加しやすくもなる
- 開発者がサブクラスを定義した際に、メソッドの実装忘れやメソッド名に間違いがあればコンパイルエラーが起き、コーディングミスを防ぐ

```ruby
module Iterator
  def has_next?
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end

  def next
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
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
```
