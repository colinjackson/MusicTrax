class Note < ActiveRecord::Base
  validates :user, :track, :text, presence: true
  
  belongs_to :user, inverse_of: :notes
  belongs_to :track, inverse_of: :notes
end
