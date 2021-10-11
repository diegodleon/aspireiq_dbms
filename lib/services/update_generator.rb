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
        id = mutation['_id'] 
        src_array.each_with_index do |elem, idx|
          return idx if elem['_id'] == id
        end
        nil
      end

      def get_elements
        hash_clone = mutation.clone
        hash_clone.delete('_id')
        hash_clone.to_a.first
      end
  end
end