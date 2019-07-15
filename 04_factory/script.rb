# javaのfremeworkを module/require/includeを使って実現する

# factory patternで実装されるインスタンスが持つべきインターフェイスを決める抽象クラス
# 具体的な実装はConcreateProduct(IdCard)が持つ
module Product
  def use
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

# Creator
module Factory
  def create(owner) # owner is String type
    product = create_product(owner)
    register_product(product)

    product
  end

  private

  def create_product(owner) # owner is String type
  end

  def register_product(product)
  end
end

# ConcreateProduct
# 作られるProductがどのような振る舞いをするのかの具体的な実装を行う
class IdCard
  include Product

  attr_reader :owner

  def initialize(owner) # owner is String type
    @owner = owner
    puts "#{@owner} のカードを作ります"
  end

  def use
    puts "#{@owner} のカードを使います"
  end
end

# 具体的なProduct(IdCard)を作るConcreateCreator
class IdCardFactory
  include Factory

  def initialize
  end

  private

  def owners
    @owners ||= []
  end

  def create_product(owner)
    IdCard.new(owner)
  end

  def register_product(product)
    owners << product.owner
  end
end

class Main
  def self.execute
    id_card_factory = IdCardFactory.new
    card1 = id_card_factory.create('結城')
    card2 = id_card_factory.create('とむら')
    card3 = id_card_factory.create('佐藤')

    card1.use
    card2.use
    card3.use
  end
end

Main.execute
