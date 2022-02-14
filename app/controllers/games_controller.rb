require "json"
require "open-uri"

class GamesController < ApplicationController
  @letters = [*('A'..'Z')].sample(10)

  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @word = params[:word]
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @word_serialized = URI.open(@url).read
    @response = JSON.parse(@word_serialized)
    if valid_word(@word) == false
      @message = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif @response["found"] == false
      @message = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def valid_word(word)
    @found = false
    @word_array = word.split();
    @found = true if @letters&@word_array == @word_array
    return @found
  end
end
