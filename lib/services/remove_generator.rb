module Services
  class RemoveGenerator

    attr_reader :mutation, :type, :src_array

    def initialize(mutation, type, src_array)
      @mutation       = mutation
      @type           = type
      @src_array      = src_array
    end

    def generate
      idx = index_of
      return "#{type}.#{idx}" if idx
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

  end
end