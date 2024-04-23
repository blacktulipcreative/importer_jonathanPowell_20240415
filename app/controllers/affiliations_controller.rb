class AffiliationsController < ApplicationController
  before_action :set_affiliation, only: %i[ show update destroy ]

  # GET /affiliations
  def index
    @affiliations = Affiliation.all

    render json: @affiliations
  end

  # GET /affiliations/1
  def show
    render json: @affiliation
  end

  # POST /affiliations
  def create
    @affiliation = Affiliation.new(affiliation_params)

    if @affiliation.save
      render json: @affiliation, status: :created, location: @affiliation
    else
      render json: @affiliation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /affiliations/1
  def update
    if @affiliation.update(affiliation_params)
      render json: @affiliation
    else
      render json: @affiliation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /affiliations/1
  def destroy
    @affiliation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliation
      @affiliation = Affiliation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def affiliation_params
      params.fetch(:affiliation, {})
    end
end
