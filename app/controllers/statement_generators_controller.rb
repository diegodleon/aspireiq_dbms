class StatementGeneratorsController < ApplicationController

  # POST /generate_update_statement
  def generate_update_statement
    service = ::Services::StatementGenerator.new(original_document_param.to_h['posts'], mutation_object_param.to_h['posts'], 'posts')
    render json: service.execute
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
