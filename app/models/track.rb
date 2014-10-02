class Track < ActiveRecord::Base
  validates :name, :album, presence: true
  
  belongs_to :album, inverse_of: :tracks
  has_one :band, through: :album, source: :band
end
