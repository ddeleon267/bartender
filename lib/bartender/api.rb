class Api
  def self.get_drinks(ingredient)
    ## what is my endpoint?
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient}"
    ## how do I go there and get the data I need?
    response = Net::HTTP.get(URI(url))
    ## how do I handle that response and parse it into meaningful json?
    drinks = JSON.parse(response)["drinks"]
    ### how do I make drink OBJECTS from that data?
    drinks.each do |drink_details|
      name = drink_details["strDrink"]
      drink_id = drink_details["idDrink"]
      Drink.new(name: name, drink_id: drink_id, ingredient: ingredient)
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
  end

end

## service file/class. It's responsible for communicating with my api -
## going out to it, getting my information, and returning it
