class ListController < ApplicationController
  before_action :set_list, only: %i(show edit update destroy)
  before_action :correct_user, only: [:destroy, :edit]
  
  def show
    redirect_to :root if @list.blank?
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = 'リストの作成が完了しました。'
      redirect_to :root
    else
      @list.valid?
      render action: :new
    end
  end
  
  def edit
    @list = List.find_by(id: params[:id])
    redirect_to :root if @list.blank?
  end

  def update
    if @list.update_attributes(list_params)
      flash[:notice] = 'リストの編集が完了しました。'
      redirect_to :root
    else
      @list.valid?
      render action: :edit
    end
  end

  def destroy
    @list.destroy
    flash[:notice] = 'リストの削除が完了しました。'
    redirect_to :root
  end

  private
  
  def list_params
    params.require(:list).permit(:title).merge(user: current_user)
  end

  def set_list
    @list = List.find_by(id: params[:id])
  end
  
  def correct_user
    @list = current_user.lists.find_by(id: params[:id])
    unless @list
      redirect_to :root
    end
  end
end