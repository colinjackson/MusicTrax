class AddLiveAlbumToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :live_album, :boolean, null: false, default: false
  end
end
