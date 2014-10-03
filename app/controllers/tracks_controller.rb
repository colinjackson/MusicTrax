class TracksController < ApplicationController
  before_filter :ensure_signed_in
  
  def new
    @track = Album.find(params[:id]).tracks.new
    render :new
  end
  
  def create
    album = Album.find(params[:track][:album_id])
    @track = album.tracks.new(track_params)
    
    if album.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = album.errors.full_messages
      render :new
    end
  end
  
  def show
    @track = Track.find(params[:id])
    render :show
  end
  
  def edit
    @track = Track.find(params[:id])
    render :edit
  end
  
  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    track = Track.find(params[:id])
    album = track.album
    if track.destroy
      redirect_to album_url(album)
    else
      flash[:errors] = band.errors.full_messages
      redirect_to :back
    end
  end
  
  def create_note
    note = Track.find(params[:track][:id]).notes.new(note_params)
    note.user = current_user
    
    flash[:errors] = note.errors.full_messages if !note.save
    
    redirect_to track_url(note.track)
  end
  
  def destroy_note
    note = Note.find(params[:id])
    track = note.track
    
    if note.user != current_user
        render "YOU'RE TRYING TO BREAK SOMEONE ELSE'S STUFF!",
          status: :forbidden
    elsif note.destroy
      redirect_to track_url(track)
    else
      flash[:errors] = note.errors.full_messages
      redirect_to track_url(track)
    end
      
  end
  
  private
  def track_params
    if params[:track][:bonus_track] == "true"
      params[:track][:bonus_track] = true
    else
      params[:track][:bonus_track] = false
    end
    
    params.require(:track).permit(:name, :bonus_track, :lyrics, :album_id)
  end
  
  def note_params
    params.require(:note).permit(:text)
  end
end
