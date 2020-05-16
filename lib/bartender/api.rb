class Api
  def self.get_drinks(ingredient)
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient}"


    response = Net::HTTP.get(URI(url))

    drinks = JSON.parse(response)["drinks"]

    new_ingredient = Ingredient.new(ingredient)
    drinks.each do |drink_details|
      name = drink_details["strDrink"]
      drink_id = drink_details["idDrink"]
      new_drink = Drink.new(name: name, drink_id: drink_id, ingredient: ingredient)
      new_ingredient.drinks << new_drink
    end
  end

  def self.getDrinkDetails(drink) ## drink_object
    ## what is my endpoint?
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink.drink_id}"
    ## how do I go there and get the data I need
    response = Net::HTTP.get(URI(url))
    # how do I parse the response into meaningful json data?
    drink_details = JSON.parse(response)["drinks"].first

    ## what do I want to do from there?
    ## add an attribute on my EXISTING drink obj
    drink.instructions = drink_details["strInstructions"]
    drink.glass = drink_details["strGlass"]
    drink_details.keys.each do |k|

      drink.ingredients << drink_details[k] if (k.include?("Ingredient")) && drink_details[k]
      drink.measures << drink_details[k] if (k.include?("Measure")) && drink_details[k]
    end

  end

end

## service file/class. It's responsible for communicating with my api -
## going out to it, getting my information, and returning it
