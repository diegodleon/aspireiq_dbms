class StatementGeneratorsController < ApplicationController
  before_action :set_statement_generator, only: [:show, :update, :destroy]

  # GET /statement_generators
  def index
    @statement_generators = StatementGenerator.all

    render json: @statement_generators
  end

  # GET /statement_generators/1
  def show
    render json: @statement_generator
  end

  # POST /statement_generators
  def create
    @statement_generator = StatementGenerator.new(statement_generator_params)

    if @statement_generator.save
      render json: @statement_generator, status: :created, location: @statement_generator
    else
      render json: @statement_generator.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /statement_generators/1
  def update
    if @statement_generator.update(statement_generator_params)
      render json: @statement_generator
    else
      render json: @statement_generator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /statement_generators/1
  def destroy
    @statement_generator.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement_generator
      @statement_generator = StatementGenerator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statement_generator_params
      params.fetch(:statement_generator, {})
    end
end
