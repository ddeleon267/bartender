class Ingredient
  attr_accessor :name, :drinks

  @@all = []

  def initialize(name)
    @name = name
    @drinks = []  ### will contain OBJECTS
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_ingredient(ingredient)
    self.all.find {|ing_obj| ing_obj.name == ingredient}
  end

end
