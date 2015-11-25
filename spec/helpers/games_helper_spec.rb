
describe GamesHelper do

  let(:game) { Game.create! }

  describe ".status_string" do

    subject { status_string(game) }

    context "it is an unknown word" do
      it { is_expected.to match /_+/ }
    end

    context "is is completely guessed" do
      before {
        game.target_word.chars.uniq.each { |c| game.guess!(c) }
      }

      it { is_expected.not_to include '_' }
    end
  end

  describe ".progress_message" do
    context "when the game is in progress" do
      subject { progress_message(game) }

      it { is_expected.not_to be_empty }
    end
  end

  describe ".game_color" do
    context "when the game is in progress" do
      subject { game_color(game) }

      it { is_expected.to match /#/ }
    end
  end

  describe ".dictionary_url" do
    it "returns a HTTP prefixed URL" do
      expect(dictionary_url("hello")).to match /http/
    end
  end
end
