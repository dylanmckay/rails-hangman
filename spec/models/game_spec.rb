require 'rails_helper'

RSpec.describe Game, type: :model do

  def invalid_letters(game)
    "abcdefghijklmnopqrstuvqxyz".chars - game.target_letters
  end

  let(:game) { Game.create! }

  describe "#guess!" do

    it "throws an exception if the input isn't a single character" do
      expect { game.guess!('ab') }.to raise_exception(ArgumentError)
    end

    it "is successful when a new letter is guessed" do
      expect(game.guess!('a')).to eq :guess_added
    end

    it "recognizes when a letter has already been guessed" do
      game.guess!('a')
      expect(game.guess!('a')).to eq :already_guessed
    end
  end

  context "at start" do

    it "has a target word" do
      expect(game.target_word.blank?).to eq false
    end

    it "has no guessed letters" do
      expect(game.guesses.empty?).to eq true
    end

    it "has 8 lives" do; expect(game.lives).to eq 8 end
    it "is in progress" do; expect(game.in_progress?).to eq true; end
    it "is not won" do; expect(game.won?).to eq false; end
    it "is not lost" do; expect(game.won?).to eq false; end

    it "shows all characters as unknown" do
      expect((game.characters - [nil]).length).to eq 0
    end
  end

  context "when won" do
    before(:all) do
      @game = Game.create
      @game.target_word.chars.uniq.each { |c| @game.guess!(c) }
    end

    it "knows that it is won" do; expect(@game.won?).to eq true; end
    it "is no longer in progress" do; expect(@game.in_progress?).to eq false; end
    it "is not lost" do; expect(@game.lost?).to eq false; end
    it "has more than one life" do; expect(@game.lives).to be > 0; end

    it "shows all characters in the status string" do
      expect(@game.characters.include?(nil)).to eq false
    end

    it "has the same number of correct letters as the target word" do
      expect(@game.correctly_guessed_letters.length)
        .to eq @game.target_word.chars.uniq.length
    end
  end

  context "when lost" do
    before(:each) do
      @game = Game.create
      invalid_letters(@game).take(8).each { |c| @game.guess!(c) }
    end

    it "knows that is it lost" do; expect(@game.lost?).to eq true; end
    it "has 0 lives" do; expect(@game.lives).to eq 0; end
    it "hasn't won" do; expect(@game.won?).to eq false; end

    it "throws an exception if you try another guess" do
      expect { @game.guess!('a') }.to raise_exception(Exception)
    end

    it "has incorrect letters" do
      expect(@game.incorrectly_guessed_letters.length).to be > 0
    end
  end
end
