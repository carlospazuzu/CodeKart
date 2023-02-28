class RacersController < ApplicationController
  before_action :set_racer, only: %i[update show destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @racers = Racer.all
  end

  def create
    new_racer = Racer.new(racer_params)

    if new_racer.valid?
      new_racer.save
      render json: { 'success': 'Racer successfuly created!' }, status: :created
    else
      render json: { 'errors': new_racer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @racer.destroy

    render json: { 'content': 'Racer successfully destroyed!' }, status: :no_content
  end

  def update
    updated_racer = @racer.update(racer_params)

    if updated_racer == true
      render json: { 'success': 'Racer successfuly updated!' }, status: :ok
    else
      render json: { 'error': 'An error occurred!' }, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_racer
    @racer = Racer.find(params[:id])
  end

  def record_not_found
    render json: { 'content': 'Racer not found!' }, status: :not_found
  end

  def racer_params
    params.require(:racer).permit(:name, :born_at, :image_url)
  end
end
