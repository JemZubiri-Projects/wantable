# frozen_string_literal: true

class CreatorsController < ApplicationController
  def index
    @creators = Creator.all.includes(:payouts)
    @creator = Creator.new
  end

  def show
    @creator = Creator.find(params[:id])
    @payouts = @creator.payouts.order(created_at: :desc)
  end

  def new
    @creator = Creator.new
  end

  def create
    @creator = Creator.new(creator_params)
    if @creator.save
      respond_to do |format|
        format.html { redirect_to creators_path, notice: 'Creator was successfully created.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :email)
  end
end
