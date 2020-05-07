## resposible for making drinks.

class Drink
  attr_accessor :name, :drink_id, :ingredient, :instructions, :ingredients, :glass, :measures

  @@all = []

  def initialize(name:, drink_id:, ingredient:)
    @name = name
    @drink_id = drink_id
    @ingredient = ingredient
    @ingredients = []  ## will be strings
    @measures = []  ## will be strings
    @@all << self
  end

  def self.all
    @@all
  end


end
