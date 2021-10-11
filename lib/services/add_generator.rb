module Services
  class AddGenerator

    attr_reader :mutation, :type, :src_array, :parent_id

    def initialize(mutation, type, src_array, parent_id)
      @mutation  = mutation
      @type      = type
      @src_array = src_array
      @parent_id = parent_id
    end

    def generate
      idx = index_of
      if type == StatementGenerator::MENTIONS_IDENTIFIER && parent_id
        return {"#{StatementGenerator::POSTS_IDENTIFIER}.#{idx}.#{type}" => [mutation]} if idx
      else
        return {"#{type}" => [mutation]}
      end
      nil
    end

    private

      def index_of 
        id = parent_id
        src_array.each_with_index do |elem, idx|
          return idx if elem[StatementGenerator::ID_IDENTIFIER] == id
        end
        nil
      end

  end
end