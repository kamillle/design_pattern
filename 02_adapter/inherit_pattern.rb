# 継承を使ったアダプターパターンのサンプル実装
# Bunnerクラスで定義された提供されるものと、実際に必要となるPrintモジュールで定義された必要なものである #print_weak, #print_strong の溝を
# PrintBannerというアダプターというを用いて解決する

# MainクラスはPrintモジュールで定義した2つのメソッドしかインターフェイスを知らなくなっていて、後ろにいるBunnerクラスやそのインターフェイスのことを知らなくても使えるようになっている

# 提供されるもの
class Bunner
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
module Print
  def print_weak
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end

  def print_strong
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

# アダプタークラス
class PrintBanner < Bunner
  include Print

  def initialize(string)
    super
  end

  def print_weak
    show_with_paren
  end

  def print_strong
    show_with_aster
  end
end

class Main
  def self.execute(args)
    print_bunner = PrintBanner.new(args)

    print_bunner.print_weak
    print_bunner.print_strong
  end
end

Main.execute(ARGV[0])
