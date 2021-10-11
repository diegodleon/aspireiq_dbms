module Services
  class StatementGenerator

    ID_IDENTIFIER       = '_id'
    DELETE_IDENTIFIER   = '_delete'
    MENTIONS_IDENTIFIER = 'mentions'
    POSTS_IDENTIFIER    = 'posts'
    ADD_CMD             = '$add'
    REMOVE_CMD          = '$remove'
    UPDATE_CMD          = '$update'

    attr_reader :src_array, :mutation_array, :type, :parent_id

    def initialize(src_array, mutation_array, type, parent_id = nil)
      @src_array          = src_array
      @mutation_array     = mutation_array
      @type               = type
      @parent_id          = parent_id
    end

    def execute
      return {} unless src_array && mutation_array
      output = {}

      mutation_array.each do |mutation|
        statement_obj = {}
        if mutation[MENTIONS_IDENTIFIER]
          statement_obj = StatementGenerator.new(src_array, mutation[MENTIONS_IDENTIFIER], MENTIONS_IDENTIFIER, mutation[ID_IDENTIFIER]).execute 
        else
          statement_obj = process(mutation) 
        end
        output.merge!(statement_obj)
      end

      output
    end

    private

      def process(mutation)
        statement_obj = {}
        if mutation[DELETE_IDENTIFIER]
          # $remove operation 
          statement_hash  = RemoveGenerator.new(mutation, type, src_array).generate
          if statement_hash
            statement_obj = {REMOVE_CMD => { statement_hash => true }} if statement_hash
          end
        elsif mutation[ID_IDENTIFIER]
          # $update operation        
          statement_hash  = UpdateGenerator.new(mutation, type, src_array).generate
          if statement_hash
            statement_obj = {UPDATE_CMD => statement_hash} if statement_hash
          end
        else
          # $add operation
          statement_hash = AddGenerator.new(mutation, type, src_array, parent_id).generate
          statement_obj  = {ADD_CMD => statement_hash} if statement_hash
        end
        statement_obj
      end

  end
end
