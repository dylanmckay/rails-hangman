module GamesHelper
  def status_string(game, separator="")
    if game.in_progress?
      game.characters.map { |c| c==nil ? '_' : c }.join(separator)
    else
      game.target_word
    end
  end

  def progress_message(game)
    if game.in_progress?
      "In progress"
    elsif game.won?
      "Won"
    elsif game.lost?
      "Lost"
    else
      fail
    end
  end

  def game_color(game)
    if game.in_progress?
      "#EDA807"
    elsif game.won?
      "#5BED07"
    elsif game.lost?
      "#D12E2E"
    else
      fail
    end
  end

  def dictionary_url(word)
    "http://dictionary.reference.com/browse/#{word}"
  end
end
