require "open-uri"

class GamesController < ApplicationController
  def score
    # The word can’t be built out of the original grid
    # 1. only contains letters from the array (used once)
    @letters = params[:letters].chars
    @characters = params[:submission].chars
    used = (@characters - @letters).empty?

    # The word is valid according to the grid, but is not a valid English word
    # 2. part 1 == true && checks API found: == "false"
    apicall = params[:submission]
    url = "https://wagon-dictionary.herokuapp.com/#{apicall}"
    truorfals = URI.open(url).read
    realword = JSON.parse(truorfals)
    valid = realword["found"]
    @answer = if used && valid
                "Good Job!"
              else
                "Try again asshole!"
              end
  end

  def new
    options = ("a".."z").to_a
    @letters = []
    10.times do
      @letters << options.sample
    end
  end
end
