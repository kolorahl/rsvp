require 'yaml'

module Rsvp::Parsers
  class Yaml
    # Constructs a new YAML schema parser.
    #
    # @param src (String) the YAML source content to use when generating a
    #   schema object.
    # @param is_file (Boolean) defaults to `false`. When `true`, treats `src` as
    #   a file path rather than a YAML source string.
    def initialize(src, is_file=false)
      @src = is_file ? File.read(src) : src
    end

    def generate
      data = YAML.load(@src)
      hash_parser = Rsvp::Parsers::Hash.new(data)
      schema = hash_parser.generate
      if schema
        schema
      else
        @errors = hash_parser.errors
        nil
      end
    end

    def errors
      @errors or []
    end
  end
end
