module Services
  class StatementGenerator

    ID_IDENTIFIER     = '_id'
    DELETE_IDENTIFIER = '_delete'

    attr_reader :src_array, :mutation_array, :type

    def initialize(src_array, mutation_array, type)
      @src_array          = src_array
      @mutation_array     = mutation_array
      @type               = type
    end

    def execute
      return {} unless src_array && mutation_array
      output = {}

      puts "DIEGO ----- src_array: #{src_array} mutation_array: #{mutation_array} type: #{type}"

      mutation_array.each do |mutation|
        statement_obj = {}
        if mutation['mentions']
          puts "In Mentions"
          statement_obj = StatementGenerator.new(src_array, mutation['mentions'], 'mentions').execute 
        else
          statement_obj = process(mutation) 
        end
        output.merge!(statement_obj)
      end

      output
    end

    private

      def process(mutation)
        if mutation[DELETE_IDENTIFIER]
          # $remove operation 
          statement_str  = RemoveGenerator.new(mutation, type, src_array).generate
          if statement_str
            statement_obj = {"$remove" => { statement_str => true }}
            return statement_obj
          end
        elsif mutation[ID_IDENTIFIER]
          # $update operation        
          statement_hash  = UpdateGenerator.new(mutation, type, src_array).generate
          if statement_hash
            statement_obj = {'$update' => statement_hash}
            return statement_obj
          end
        else
          # $add operation
          statement_hash = AddGenerator.new(mutation, type, src_array).generate
          statement_obj  = {'$add' => statement_hash}
          return statement_obj
        end
      end

  end
end

# INPUT: Add post; notice that there is no _id because the post doesn't exist yet
# {"posts": [{"value": "four"}] }
# OUTPUT: Add post
# {"$add": {"posts": [{"value": "four"}] }}

# Params:
#   originalDocument
#   mutationObject

# Return:
#   responseStatement


# Cases:
  
#   mutationObject contains _id -> Update
#     posts

#       mentions
#   mutationObject contains _delete -> Remove

#   else add


#   Checar que existe Posts en mutationObject.
#     Para cada elemento de Posts y sus Mentions:

#   Si el Array contiene Elementos:
#     Iterar sobre el arreglo de Elementos.
#       Si el elemento contiene _id es un Update
#         Busca el elemento con el _id
#         Recuerda su Indice en el array
#         Arma la operacion
#       Si el element  contiene _delete es un remove
#         Busca el elemento con el _id
#         Recuerda su Indice en el array
#         Arma la operacion
#       Si no es un Add
#         Busca el elemento con el _id
#         Recuerda su Indice en el array
#         Arma la operacion

