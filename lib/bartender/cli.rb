class Cli
  def run
    puts "  "
    puts "Hello and welcome to my bartending app!"
    ## present user with next steps
    prompt_ingredient
    prompt_user
    input = gets.strip.downcase

    while input != "exit"
      if input == 'list'
        ## go ahead and list my drinks with this ingredient again
        drinks = found_ingredient.drinks
        print_drinks(drinks)
      elsif input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).drinks.length
        drink =  Ingredient.find_by_ingredient(@ingredient).drinks[input.to_i - 1]
        ## go ahead and get the details for that drink
        Api.getDrinkDetails(drink) if !drink.instructions ## only hitting the api if I haven't updated this drink object already
        print_drink(drink) # print the details for THIS drink
      elsif input == 'ingredient'
        prompt_ingredient
      else
        puts "I do not understand - please try again"
      end
      prompt_user ## restart the process if user entered invalid input
      input = gets.strip.downcase
    end
    puts " "
    puts "bye!"
  end

  def spacer
    puts "--------------------"
    puts " "
  end

  def print_drinks(drinks)
    puts " "
    puts "Here are the drinks made with #{@ingredient}"
    drinks.each.with_index(1) do |drink, index|
      puts "#{index}. #{drink.name}"
    end
    puts " "
  end

  def print_drink(drink)
    spacer
    puts "#{drink.name} Recipe"
    spacer
    puts "Glass: #{drink.glass}"
    spacer
    puts "Ingredients: "
    drink.ingredients.each_with_index do |ingredient, index|
      puts "#{ingredient}: #{drink.measures[index]}"
    end
    spacer
    puts "Instructions: #{drink.instructions}"
  end


  def prompt_ingredient
    puts "  "
    puts "Enter an ingredient to see drinks made with that ingredient."
    puts "  "
    @ingredient = gets.strip.downcase
    Api.get_drinks(@ingredient) if !Ingredient.find_by_ingredient(@ingredient)
    print_drinks(Ingredient.find_by_ingredient(@ingredient).drinks)
  end

  def prompt_user
    puts " "
    puts "Select a number to see the instructions for a drink; type 'list'
    to see the list again, 'ingredient' to select a new ingredient, or 'exit' to exit"
    puts " "
  end

end
