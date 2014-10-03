class AddBonusTrackToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :bonus_track, :boolean, null: false, default: false
  end
end
