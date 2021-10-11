module Services
  class UpdateGenerator

    attr_reader :mutation, :type, :src_array

    def initialize(mutation, type, src_array)
      @mutation     = mutation
      @type         = type
      @src_array    = src_array
    end

    def generate
      idx       = index_of
      key,value = get_elements
      return {"#{type}.#{idx}.#{key}" => value} if idx
      nil
    end

    private

      def index_of 
        id = mutation[StatementGenerator::ID_IDENTIFIER] 
        src_array.each_with_index do |elem, idx|
          return idx if elem[StatementGenerator::ID_IDENTIFIER] == id
        end
        nil
      end

      def get_elements
        hash_clone = mutation.clone
        hash_clone.delete(StatementGenerator::ID_IDENTIFIER)
        hash_clone.to_a.first
      end
  end
end