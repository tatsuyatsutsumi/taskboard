class CardController < ApplicationController
  before_action :set_card, only: %i(show edit update destroy)
  before_action :correct_user, only: [:destroy, :edit, :show]
  
  def new
    @card = Card.new
    @list = List.find_by(id: params[:list_id])
  end

  def create
    @list = List.find_by(id: params[:list_id])
    @card = Card.new(card_params)
    if @card.save
      flash[:notice] = 'カードの作成が完了しました。'
      redirect_to :root
    else
      @card.valid?
      render action: :new
    end
  end

  def show
    redirect_to :root if @card.blank?
  end

  def edit
    @lists = List.where(user: current_user)
    redirect_to :root if @card.blank?
  end
  
  def update
    @lists = List.where(user: current_user)
    if @card.update_attributes(card_params)
      flash[:notice] = 'カードの編集が完了しました。'
      redirect_to :root
    else
      @card.valid?
      render action: :edit
    end
  end

  def destroy
    @card.destroy
    flash[:notice] = 'カードの削除が完了しました。'
    redirect_to :root
  end

  private
  
  def card_params
    params.require(:card).permit(:title, :memo, :list_id)
  end
  
  def set_card
    @card = Card.find_by(id: params[:id])
  end
  
  def correct_user
    @corrent_user_cards = Card.where(list_id:current_user.lists.ids)
    @target_card = Card.find_by(id: params[:id])
    redirect_to :root unless @corrent_user_cards.include?(@target_card)
  end
end