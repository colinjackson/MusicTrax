class Band < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :albums, inverse_of: :band, dependent: :destroy
  has_many :tracks, through: :albums, source: :tracks
  
  def ==(other)
    other.is_a?(Band) && self.id == other.id
  end
end
