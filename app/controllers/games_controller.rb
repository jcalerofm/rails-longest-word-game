require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @attempt = params[:attempt].strip.upcase
    @letters = params[:letters]

    @word_in_grid = check_if_word_is_in_grid(@attempt, @letters)
    @word_exist = api(@attempt)['found']
    @points = api(@attempt)['length']
  end

  private

  def api(attempt)
    api_url = 'https://wagon-dictionary.herokuapp.com'
    attempt_url = "#{api_url}/#{attempt}"
    attempt_serialized = open(attempt_url).read
    _attempt_hash = JSON.parse(attempt_serialized)
  end

  def check_if_word_is_in_grid(attempt, letters)
    attempt.chars.all? { |c| attempt.count(c) <= letters.chars.count(c) }
  end
end
