module Services
  class AddGenerator

    attr_reader :mutation, :type, :src_array

    def initialize(mutation, type, src_array)
      @mutation  = mutation
      @type      = type
      @src_array = src_array
    end

    def generate
      {"#{type}" => [mutation]}
    end

  end
end