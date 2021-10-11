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
        id = mutation['_id'] 
        src_array.each_with_index do |elem, idx|
          return idx if elem['_id'] == id
        end
        nil
      end

  end
end