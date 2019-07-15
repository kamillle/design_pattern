# 委譲を使ったアダプターパターンのサンプル実装

# 提供されるもの
class Banner
  def initialize(string)
    @string = string
  end

  # @string を () で囲う
  def show_with_paren
    puts "(#{@string})"
  end

  # @string を ** で囲う
  def show_with_aster
    puts "*#{@string}*"
  end
end

# 必要なもの
class Print
  def print_weak
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end

  def print_strong
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

# アダプタークラス
class PrintBanner < Print
  def initialize(string)
    @banner = Banner.new(string)
  end

  def print_weak
    @banner.show_with_paren
  end

  def print_strong
    @banner.show_with_aster
  end
end

class Main
  def self.execute(args)
    print_banner = PrintBanner.new(args)

    print_banner.print_weak
    print_banner.print_strong
  end
end

Main.execute(ARGV[0])
