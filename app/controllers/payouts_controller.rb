# frozen_string_literal: true

class PayoutsController < ApplicationController
  before_action :set_creator, only: %i[new update create]

  def new
    @payout = @creator.payouts.new

    respond_to do |format|
      format.turbo_stream { render :new }
      format.html
    end
  end

  def create
    @payout = @creator.payouts.new(payout_params)
    if @payout.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to creator_path(@creator) }
      end
    else
      render :new
    end
  end

  def update
    @payout = @creator.payouts.find(params[:id])
    if @payout.mark_as_paid!
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_creator
    @creator = Creator.find(params[:creator_id])
  end

  def payout_params
    params.require(:payout).permit(:amount, :status)
  end
end
