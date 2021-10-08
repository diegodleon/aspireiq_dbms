class StatementGeneratorsController < ApplicationController

  # POST /generate_update_statement
  def generate_update_statement
    render json: {:original_document => original_document_param, :mutation_object => mutation_object_param}
  end

  private
    # Only allow a list of trusted parameters through.
    def original_document_param
      params.require(:original_document).permit!
    end

    def mutation_object_param
      params.require(:mutation_object).permit!
    end
end
