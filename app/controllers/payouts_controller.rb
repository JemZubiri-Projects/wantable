# frozen_string_literal: true

class PayoutsController < ApplicationController
  def new
    @creator = Creator.find(params[:creator_id])
  end

  def create
    @creator = Creator.find(params[:creator_id])
    @payout = @creator.payouts.new(payout_params.merge(status: :pending))

    if @payout.save
      redirect_to creator_path(@creator)
    else
      render :new
    end
  end

  def update
    @payout = Payout.find(params[:id])
    @payout.mark_as_paid!
    redirect_back fallback_location: creators_path
  end

  private

  def payout_params
    params.require(:payout).permit(:amount)
  end
end
