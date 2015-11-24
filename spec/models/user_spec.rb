require 'rails_helper'

RSpec.describe User, type: :model do

  context "new user" do
    before {
      @user = User.create!(username: "dylan")
    }

    it "has no wins" do; expect(@user.win_count).to eq 0; end
    it "has no losses" do; expect(@user.lose_count).to eq 0; end
    it "has no unfinished games" do; expect(@user.unfinished_count).to eq 0; end
    it "has a 0% win rate" do; expect(@user.win_percentage).to eq 0; end
  end

  context "with one win" do
    before {
      @user = User.create!(username: "dylan")
      @user.games.create!(target_word: "abc")
      "abc".chars.each { |c| @user.games.last.guess!(c) }
    }

    it "has a 100% win percentage" do
      expect(@user.win_percentage).to eq 100
    end

    it "has no losses" do; expect(@user.lose_count).to eq 0; end

    context "and one lose" do
      before {
        @user.games.create!(target_word: "abc")
        "qwertyui".chars.each { |c| @user.games.last.guess!(c) }
      }

      it "has a lose count of 1" do; expect(@user.lose_count).to eq 1; end
      it "has a win count of 1" do; expect(@user.win_count).to eq 1; end

      it "has a 50% win rate" do
        expect(@user.win_percentage).to eq 50
      end
    end
  end

  context "with one lose" do
    before {
      @user = User.create!(username: "dylan")
      @user.games.create!(target_word: "abc")
      "qwertyui".chars.each { |c| @user.games.last.guess!(c) }
    }

    it "has a win count of 0" do; expect(@user.win_count).to eq 0; end
    it "has a lose count of 1" do; expect(@user.lose_count).to eq 1; end

    it "has a 0% win percentage" do
      expect(@user.win_percentage).to eq 0
    end
  end

end
