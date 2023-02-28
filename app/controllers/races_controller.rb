class RacesController < ApplicationController
  before_action :set_race, only: %i[show destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @races = Race.all
  end

  def create
    new_race = Race.create(race_params)

    if new_race.valid?
      new_race.save
      render json: { 'success': 'Race successfully created!' }, status: :created
    else
      render json: { 'errors': new_race.errors }, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @race.destroy

    render json: { 'content': 'Race successfuly destroyed!' }, status: :no_content
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def record_not_found
    render json: { 'error': 'Record not found!' }, status: :not_found
  end

  def race_params
    params.permit(:place, :tournament_id, :date, placements_attributes: %i[racer_id position])
  end
end
