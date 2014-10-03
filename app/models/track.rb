class Track < ActiveRecord::Base
  validates :name, :album, presence: true
  validates :bonus_track, inclusion: { in: [true, false] }
  
  after_initialize :ensure_bonus_track
  
  belongs_to :album, inverse_of: :tracks
  has_many :notes, inverse_of: :track, dependent: :destroy
  has_one :band, through: :album, source: :band
  
  def bonus_track?
    self.bonus_track
  end
  
  private
  def ensure_bonus_track
    self.bonus_track ||= false
  end
end
