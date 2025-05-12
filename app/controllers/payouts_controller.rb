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
    if @payout.update(status: :paid)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("payout_#{@payout.id}", @payout) }
        format.html { redirect_to creator_path(@creator), notice: 'Payout marked as paid.' }
      end
    else
      render :show
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
