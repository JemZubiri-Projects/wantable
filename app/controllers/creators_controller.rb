# frozen_string_literal: true

class CreatorsController < ApplicationController
  before_action :set_creator, only: %i[show edit update destroy]

  def index
    @creators = Creator.all.includes(:payouts)
    @creator = Creator.new
  end

  def show
    @payouts = @creator.payouts.order(updated_at: :desc)
  end

  def new
    @creator = Creator.new
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    @creator.update(creator_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to creators_path, notice: 'Creator updated.' }
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to creator_path(@creator) }
    end
  end

  def create
    @creator = Creator.new(creator_params)
    if @creator.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to creators_path, notice: 'Creator was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @creator.destroy
    redirect_to creators_path
  end

  private

  def set_creator
    @creator = Creator.find(params[:id])
  end

  def creator_params
    params.require(:creator).permit(:name, :email)
  end
end
