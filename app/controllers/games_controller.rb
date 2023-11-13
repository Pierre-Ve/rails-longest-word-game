require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = set_letters
  end
  def score
    word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_api = URI.open(url).read
    @answer = JSON.parse(result_api)['found']
    @included_in_letters = test_word(word, params[:letters])
  end

  def set_letters
    letters = []
    8.times do
      letters << ('A'..'Z').to_a.sample
    end
    return letters
  end

  def test_word(word, letters)
    if word.length == 1
      return letters.include?(word)
    elsif !letters.include?(word.split('').last)
      return false
    else
      return true && test_word(word.split('').pop.join)
    end
  end
end
