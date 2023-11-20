class ListsController < ApplicationController
  before_action :set_find, only: %i[show]
  # see all lists
  def index
    @lists = List.all
  end

  # see one list and its details infos
  def show
  end

  # create a list with get=>new  and post=>create
  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)
    redirect_to list_path(@list)
  end

  private

  def set_find
    @list = List.find(params[:id])
  end

  def list_params
    params.require('list').permit(:name)
  end
end
