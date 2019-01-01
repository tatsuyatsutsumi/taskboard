class CardController < ApplicationController
  def new
    @card = Card.new
    @list = List.find_by(id: params[:list_id])
  end

  # ==========ここから編集する==========
  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to :root
    else
      @card.valid?
      render action: :new
    end
  end

  private
    def card_params
      params.require(:card).permit(:title, :memo, :list_id)
    end
  # ==========ここまで編集する==========

end