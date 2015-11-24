
class GetWord
  def call
    File.read("words.txt")
        .split("\n")
        .map(&:downcase)
        .uniq
        .sample
  end
end
