# copy from: https://qiita.com/yuji_ariyasu/items/588fef6062b3c7149509#4章-アルゴリズムを交換する--strategy

# Context, Strategy(戦略)を利用する
# ConcreateStrategyのインスタンスを持っており、そのインスタンスが持つStrategyが定めたAPIを呼び出す
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = '月次報告'
    @text = ['順調', '最高の調子']
    @formatter = formatter
  end

  # formatterが提供する #output_report を呼び出す
  # formatterのクラス名がなんであるかは気していない
  def output_report
    formatter.output_report(self) # 委譲
  end
end

# Stragety, 戦略を利用するためのAPI名を決めるクラス
# ConcreateStrategyはこのクラスが決めたAPI名で振る舞いを実装する
class Formatter
  def output_report(context)
    raise 'Abstract method called'
  end
end

# ConcreateStrategy
class HTMLFormatter < Formatter
  def output_report(context)
    puts "<title>#{context.title}</title>"
    puts '<body>'
    context.text.each do |line|
      puts "<p>#{line}</p>"
    end
    puts '</body>'
  end
end

# ConcreateStrategy
class PlainTextFormatter < Formatter
  def output_report(context)
    puts("***#{context.title}***")
    context.text.each do |line|
      puts("***#{line}***")
    end
  end
end

class Main
  def self.call
    report = Report.new(HTMLFormatter.new)
    report.output_report

    report.formatter = PlainTextFormatter.new
    report.output_report
  end
end

Main.call
