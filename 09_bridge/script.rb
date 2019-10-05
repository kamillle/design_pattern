# 機能のクラス階層
# Display
#       └ CountDisplay
# 新しい機能を追加する場合はCountDisplayを継承した新しいクラスを作らないといけないケースがある

# 引数implは #raw_open, #raw_print, #raw_close を持っている必要があり、
# このクラスはそれらのAPIを使用して何かを表示する
class Display
  attr_accessor :impl

  # @param [DisplayImpl OR SubClass] impl DisplayImplが提供するAPIを実装しているクラス
  #                                       Displayという機能のみを決めるクラス階層と
  #                                       DisplayImplという実装を決めるクラス階層を繋ぐ
  def initialize(impl)
    @impl = impl # 表示の実装をimplに委譲している
  end

  # Kernel#openとかぶるためx_openとしている
  # 表示の前処理を行う
  def x_open
    impl.raw_open
  end

  # Kernel#printとかぶるためx_printとしている
  # 表示そのもの
  def x_print
    impl.raw_print
  end

  # 表示の後処理を行う
  def close
    impl.raw_close
  end

  # 表示に必要な順番を管理する
  def display
    x_open
    x_print
    close
  end
end

# 基礎的な機能のみを提供する親(Display)を拡張したサブクラス
# 指定した回数で、繰り返し表示を行う
class CountDisplay < Display
  # @param [Integer] times 繰り返しの回数
  def multi_display(times)
    x_open

    times.times do
      x_print
    end

    close
  end
end

# 実装のクラス階層
# DisplayImpl(API名のみ決める)
#           └ StringDisplayImp(APIの実装(振る舞いを決める)を定義)
# 新しい実装が必要な場合は親のDisplayImplを継承(OR mix-in)すればいいので
# クラス階層が複雑になりにくい

# 表示に関するAPIのみ定義する
class DisplayImpl
  def raw_open; end
  def raw_print; end
  def raw_close; end
end

# DisplayImplが定めた表示に関するAPIの振る舞いを定義する
#
# 下記のような文字列を返すAPIを提供する
# +------+
# |string|
# +------+
class StringDisplayImpl < DisplayImpl
  attr_reader :string, :width

  # @param [String] string
  def initialize(string)
    @string = string
    @width = string.length
  end

  def raw_open
    print_line
  end

  def raw_print
    puts "|#{string}|"
  end

  def raw_close
    print_line
  end

  private

  def print_line
    print '+' # 枠の角を表現する

    width.times do
      print '-'
    end

    puts '+' # 枠の角を表現する
  end
end

class Main
  # @param [Array] args
  def self.call(args)
    d1 = Display.new(StringDisplayImpl.new('Hello, Japan.'))
    d2 = CountDisplay.new(StringDisplayImpl.new('Hello, World.'))
    d3 = CountDisplay.new(StringDisplayImpl.new('Hello, Universe.'))
    d1.display
    d2.display
    d3.display
    d3.multi_display(5)
  end
end

Main.call(ARGV)
