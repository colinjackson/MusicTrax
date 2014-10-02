class Album < ActiveRecord::Base
  validates :name, :band, presence: true
  
  belongs_to :band, inverse_of: :albums
  has_many :tracks, inverse_of: :album, dependent: :destroy
end
