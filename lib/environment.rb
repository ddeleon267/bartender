### listing all dependencies for my project.


require "pry"
require "httparty"  ## interacting with my api
require "json"  ### parsing data from api in json

require_relative "./bartender/cli"
require_relative "./bartender/api"
require_relative "./bartender/drink"
