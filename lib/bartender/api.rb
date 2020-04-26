class Api
  def self.get_drinks(ingredient)
    ## what is my endpoint
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient}"
    ## how do I go there and get what I need?
    response = Net::HTTP.get(URI(url))
    ## how do I handle that json and turn it into meanringful data
    drinks = JSON.parse(response)["drinks"]
    ### how do I make drink OBJECTS from that data
    drinks.each do |drink_details|
      name = drink_details["strDrink"]
      drink_id = drink_details["idDrink"]
      Drink.new(name: name, drink_id: drink_id, ingredient: ingredient)
    end
  end

  def self.getDrinkDetails(drink) ## drink_object
    ## what is my endpoint
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink.drink_id}"
    ## how do I go there and get what I need
    response = Net::HTTP.get(URI(url))

    drink_details = JSON.parse(response)["drinks"].first
    # how do I parse the response
    ## what do I want to do from there
    ## add an attribute on my EXISTING drink obj
    drink.instructions = drink_details["strInstructions"]
    binding.pry
  end

end

## service file/class. It's responsible for communicating with my api -
## going out to it, getting my information, and returning it
