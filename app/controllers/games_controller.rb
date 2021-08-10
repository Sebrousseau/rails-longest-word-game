require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ("A".."Z").to_a[rand(26)] }
  end

  def score
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      ans_serialized = URI.open(url).read
      ans = JSON.parse(ans_serialized)
      if ans["found"] && letter_included?(params[:word].upcase, params[:letters])
        @answer = "Congratulation! #{params[:word].capitalize} is an Enslish word!"
        @score = params[:word].length
        @cache = ActiveSupport::Cache::MemoryStore.new
        @cache.write("score", @score )
      elsif ans["found"]
        @answer = "Hmm! #{params[:word].capitalize} is an Enslish word but not in the grid!"
      else
        @answer = "Sorry #{params[:word]} is not an English word!"
      end
  end

  def letter_included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

end
