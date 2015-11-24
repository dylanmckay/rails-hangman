class User < ActiveRecord::Base
  has_many :games

  def self.sorted_by_rank
    User.all.sort_by { |u| -u.win_percentage }
  end

  def win_count
    games.all.select { |game| game.won? }.count
  end

  def lose_count
    games.all.select { |game| game.lost? }.count
  end

  def unfinished_count
    games.all.select { |game| game.in_progress? }.count
  end

  def win_percentage
    if games.empty?
      0
    else
      ((win_count.to_f/games.length.to_f)*100.0).to_i
    end
  end
end
