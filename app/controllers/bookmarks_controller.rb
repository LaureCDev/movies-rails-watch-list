class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private
  # protection contre l'injection sql
  def bookmark_params
    params.require('bookmark').permit(:comment, :movie_id)
  end

  # ceci permet de pas chercher l'id dans tout le code,
  # on appelle cette fonction avec before_action en début de controller
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  # idem avec list_id, id de la table list, jointe
  def set_list
    @list = List.find(params[:list_id])
  end

end
