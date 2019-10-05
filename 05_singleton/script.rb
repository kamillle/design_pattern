class Singleton
  class << self
    def instance
      singleton
    end

    private

    # メモ化しておくことで何度初期化しても同じobject_idのインスタンスが返るようにする
    # メモ化以外にも @@variable (クラス変数) を使う手段もある
    # @@singleton = self.new
    def singleton
      @singleton ||= self.new
    end
  end

  private

  # constメソッドはprivate化して、外から .new が実行できないようにする
  def initialize
    puts 'インスタンスを生成しました'
  end
end

class Main
  def self.execute(args = nil)
    puts 'start'

    singleton1 = Singleton.instance
    singleton2 = Singleton.instance

    if singleton1.object_id == singleton2.object_id
      puts 'singleton1 is same object as singleton2'
    else
      puts 'singleton1 is not same object as singleton2'
    end

    puts 'end'
  end
end

# return below
#
# start
# インスタンスを生成しました
# singleton1 is same object as singleton2
# end
Main.execute
