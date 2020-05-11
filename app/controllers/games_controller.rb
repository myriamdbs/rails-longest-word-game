require 'open-URI'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @letters = params[:letters]
    if in_grid?(params[:word].upcase, @letters)
      if english_word?(params[:word])
        @score = params[:word].length
        @result = "Congratulations! #{params[:word].upcase} is a valid English word. Your score : #{@score} points"
      else
        @result = "Sorry but #{params[:word]} doesn't seem to be a valid English word"
      end
    else
      @result = "Sorry but #{params[:word].upcase} can't be built out of #{@letters}"
    end
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    dictionary = open(url).read
    check = JSON.parse(dictionary)
    return check["found"]
  end

  def in_grid?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

end
