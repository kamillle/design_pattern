# javaのfremeworkを module/require/includeを使って実現する
module Product
  def use
    raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
  end
end

module Factory
  def create(owner) # owner is String type
    product = create_product(owner)
    register_product(product)

    product
  end

  def create_product(owner) # owner is String type
  end

  def register_product(product)
  end
end

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

class IdCardFactory
  include Factory

  def initialize
end
