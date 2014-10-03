class AlbumsController < ApplicationController
  before_filter :ensure_signed_in
  
  def new
    @album = Band.find(params[:id]).albums.new
    render :new
  end
  
  def create
    band = Band.find(params[:band][:id])
    @album = band.albums.new(album_params)
    
    if band.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = band.errors.full_messages
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    render :edit
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end
  
  def show
    @album = Album.find(params[:id])
    render :show
  end
  
  def destroy
    album = Album.find(params[:id])
    band = album.band
    if album.destroy
      redirect_to band_url(band)
    else
      flash[:errors] = band.errors.full_messages
      redirect_to :back
    end
  end
  
  private
  def album_params
    if params[:album][:live_album] == "true"
      params[:album][:live_album] = true
    else
      params[:album][:live_album] = false
    end
    
    params.require(:album).permit(:name, :live_album)
  end
end
