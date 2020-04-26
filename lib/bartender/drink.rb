class Drink

  attr_accessor :name, :drink_id, :ingredient, :instructions

  @@all = []

  def initialize(name:, drink_id:, ingredient:)
    @name = name
    @drink_id = drink_id
    @ingredient = ingredient
    @@all << self
  end

  def self.all
    @@all
  end

  def self.select_by_ingredient(ingredient)
    self.all.select {|drink| drink.ingredient == ingredient}

  end

end

## resposible for making drinks.
