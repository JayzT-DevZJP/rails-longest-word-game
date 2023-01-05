require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = 10.times.map { alphabet.sample }.join
  end

  def english_word(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word_dictionary = URI.open(url).read
    JSON.parse(word_dictionary)
    # return word['found']
  end

  def score
    @answer = params[:word]
    @letters = params[:grid]
    if @letters.chars.sort.join.include? @answer.chars.sort.join
      @result = "Sorry, but #{@answer} can't be built out of #{@letters}."
    elsif (@letters.chars.sort.join.include? @answer.chars.sort.join) && english_word(@answer)
      @result = "sorry, but #{@answer} does not seeem to be an English word..."
    else
      @result = "CONGRATULATIONS! #{@answer} is a valid English word!"
    end
  end
end
