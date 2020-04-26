class Cli
  def run
    puts "  "
    puts "Hello and welcome to my bartending app!"
    puts "  "
    puts "Enter an ingredient to see drinks made with that ingredient."
    puts "  "
    @ingredient = gets.strip.downcase
    Api.get_drinks(@ingredient) ## send query to the api - get all drinks with this ingredient
    ## display a list of drinks to the user
    print_drinks(Drink.all)
    ## present user with next steps
    prompt_user
    input = gets.strip.downcase

    while input != "exit"
      if input == 'list'
        ## go ahead and list my drinks with this ingredient again
        drinks = Drink.select_by_ingredient(@ingredient)
        print_drinks(drinks)
      elsif input.to_i > 0 && input.to_i < Drink.select_by_ingredient(@ingredient).length
        drink =  Drink.select_by_ingredient(@ingredient)[input.to_i - 1]
        ## go ahead and get the details for that drink
        Api.getDrinkDetails(drink) if !drink.instructions ## only hitting the api if I haven't updated this drink object already
        print_drink(drink) # print the details for THIS drink
      # elsif ## user picks another ingredient
          ## do some other stuff
      else
        puts "I do not understand - please try again"
      end
      prompt_user ## restart the process if user entered invalid input
      input = gets.strip.downcase
    end
    puts " "
    puts "bye!"
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
    puts drink.name
    puts drink.instructions
  end

  def prompt_user
    puts " "
    puts "Select a number to see the instructions for a drink; type 'list'
    to see the list again, 'ingredient' to select a new ingredient, or 'exit' to exit"
    puts " "
  end

end
