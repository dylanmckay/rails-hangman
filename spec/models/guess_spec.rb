require 'rails_helper'

RSpec.describe Guess, type: :model do
  it "rejects strings that aren't single letters" do
    guess = Guess.new(letter: 'abc')
    expect(guess.save).to eq false
  end

  it "rejects empty strings" do
    guess = Guess.new(letter: '')
    expect(guess.save).to eq false
  end

  it "rejects numbers" do
    guess = Guess.new(letter: '1')
    expect(guess.save).to eq false
  end

  it "rejects symbols" do
    guess = Guess.new(letter: '$')
    expect(guess.save).to eq false
  end
end
