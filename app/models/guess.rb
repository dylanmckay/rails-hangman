class Guess < ActiveRecord::Base
  validates :letter, length: { is: 1 }
  validates_format_of :letter, :with => /[a-z]/
end
