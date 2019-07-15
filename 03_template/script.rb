# 抽象クラス
# テンプレートの役割を果たす
class AbstractDisplay
  # 処理の大まかな流れを決めるメソッド
  def display
    open

    5.times do
      xprint
    end

    close
  end

  private

  # 以下は抽象メソッド
  def open
  end

  def xprint
  end

  def close
  end
end

# テンプレートが示した大まかな流れはそのままに内部処理を独自に定義することで独自の要件を果たしている
class CharDisplay < AbstractDisplay
  def initialize(char)
    @char = char
  end

  private

  def open
    print "<<"
  end

  def xprint
    print @char
  end

  def close
    puts ">>"
  end
end

class StringDisplay < AbstractDisplay
  def initialize(string)
    @string = string
    @width = string.bytesize
  end

  private

  def open
    print_line
  end

  def xprint
    puts "| #{@string} |"
  end

  def close
    print_line
  end

  def print_line
    print "+"

    @width.times do
      print "-"
    end

    puts "+"
  end
end

class Main
  def self.execute
    d1 = CharDisplay.new('H')
    d2 = StringDisplay.new("Hello, World.")
    d3 = StringDisplay.new("こんにちは。")

    d1.display
    d2.display
    d3.display
  end
end

Main.execute
