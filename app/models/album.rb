class Album < ActiveRecord::Base
  validates :name, :band, presence: true
  validates :live_album, inclusion: { in: [true, false] }
  
  after_initialize :ensure_live_album
  
  belongs_to :band, inverse_of: :albums
  has_many :tracks, inverse_of: :album, dependent: :destroy
  
  def ==(other)
    other.is_a?(Album) && self.id == other.id
  end
  
  def live_album?
    self.live_album
  end
  
  private
  def ensure_live_album
    self.live_album ||= false
  end

end
