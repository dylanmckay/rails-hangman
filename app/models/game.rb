require 'byebug'
require_relative '../services/get_word.rb'

class Game < ActiveRecord::Base
  LIVES = 8

  has_many :guesses

  before_validation :setup

  def guess!(char)
    raise ArgumentError if char.length != 1
    raise Exception if !in_progress?

    if guessed_letters.include?(char)
      :already_guessed
    else
      guesses.create!(letter: char)
      :guess_added
    end
  end

  def won?
    (target_word.chars.uniq - guessed_letters).empty?
  end

  def lost?
    !in_progress? && !won?
  end

  def in_progress?
    lives > 0 && !won?
  end

  def lives
    n = LIVES - incorrectly_guessed_letters.length
    (n > 0) ? n : 0
  end

  def target_letters
    target_word.chars.uniq
  end

  def incorrectly_guessed_letters
    guessed_letters - target_letters
  end

  def correctly_guessed_letters
    guessed_letters - incorrectly_guessed_letters
  end

  def guessed_letters
    guesses.pluck(:letter)
  end

  def characters
    target_word.chars.map { |c| guessed_letters.include?(c) ? c : nil }
  end

  private

  def setup
    self.target_word ||= GetWord.new.call
  end

end
