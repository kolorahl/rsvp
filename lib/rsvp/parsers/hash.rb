module Rsvp::Parsers
  class Hash
    # Constructs a new Ruby Hash schema parser.
    #
    # @param src (Hash) the Ruby Hash containing the schema definition.
    def initialize(src)
      unless src.is_a?(::Hash)
        throw "Source object must be a Hash; received #{src.class}"
      end
      @src = src
    end

    def generate
      nil
    end

    def errors
      []
    end
  end
end
