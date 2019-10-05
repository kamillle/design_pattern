module Entry
  class FileTreatmentException < StandardError; end

  def name
    raise NotImplementedError
  end

  def size
    raise NotImplementedError
  end

  def add(entry)
    raise FileTreatmentException
  end

  def to_string
    "#{name}(#{size})"
  end

  protected

  def print_list(prefix)
    raise NotImplementedError
  end
end

# FileクラスとかぶらないようにXfileとしている
class Xfile
  include Entry

  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def print_list(prefix)
    puts "#{prefix}/self"
  end
end

class Directory
  include Entry

  attr_accessor :directory
  attr_reader :name

  def initialize(name)
    @directory = []
    @name = name # ディレクトリ名
  end

  # サイズを動的に計算する
  def size
    directory.sum { |obj| obj.size }
  end

  def add(entry)
    directory << entry
    self
  end

  def print_list(prefix = '')
    puts "#{prefix}/#{self}"

    directory.each do |obj|
      obj.print_list("#{prefix}/#{name}")
    end
  end
end

class Main
  def self.main(args)
    puts 'Making root entries...'
    root_dir = Directory.new('root')
    bin_dir = Directory.new('bin')
    tmp_dir = Directory.new('tmp')
    usr_dir = Directory.new('usr')

    root_dir.add(bin_dir)
    root_dir.add(tmp_dir)
    root_dir.add(usr_dir)

    bin_dir.add(Xfile.new('vi', 10000))
    bin_dir.add(Xfile.new('latex', 20000))
    root_dir.print_list

    puts
    puts 'Making use entries...'
    yuki = Directory.new('yuki')
    hanako = Directory.new('hanako')
    tomura = Directory.new('tomura')

    usr_dir.add(yuki)
    usr_dir.add(hanako)
    usr_dir.add(tomura)
    yuki.add(Xfile.new('diary.html', 100))
    yuki.add(Xfile.new('Composite.java', 200))
    hanako.add(Xfile.new('memo.tex', 300))
    tomura.add(Xfile.new('game.doc', 400))
    tomura.add(Xfile.new('junk.mail', 500))
    root_dir.print_list
  end
end

Main.main(ARGV)
