require 'open-uri'
require 'json'

class GameController < ApplicationController
  def new
    chars = ('A'..'Z').to_a
    @letters = Array.new(10) { chars.sample }.join
  end

  def score
    letters = params[:lettersSample].upcase
    word = params[:word].upcase
    @message = ""

    if word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      response = URI.parse("https://dictionary.lewagon.com/#{word}")
      json = JSON.parse(response.read)
      if json['found']
        # Correct
        @message = "Congratulations! #{word} is a valid english word"
      else
        # Not english
        @message = "Sorry but #{word}, does not seem to be an english word"
      end
    else
      # Doesn't use letters
      @message = "Sorry but #{word}, can't be built out of #{letters.chars.join(", ")}"
    end
  end
end
