require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @answer = params[:word]
    @letters = params[:letters].split(' ')
    @array_answer = @answer.split('')
    sum = 0
    @array_answer.each do |letter|
      if !@letters.include?(letter)
        sum += 1
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    @existing = user['found']

    if sum.positive?
      @result = "Sorry but #{@answer.upcase} can't be built out of #{@letters.join(',')}"
    elsif @existing == false
      @result = "Sorry but #{@answer.upcase} does not seem to be an english word"
    else
      @result = "Congratulations! #{@answer.upcase} is a valid english word"
    end
  end
end

