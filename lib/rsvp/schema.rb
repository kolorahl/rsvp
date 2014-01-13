# Load all custom rules
require 'lib/rsvp/rules/all'

module Rsvp
  # Represents a schema object used to validate other Ruby objects.
  class Schema
    # Constructs a new schema to validate objects against.
    #
    # @param rule (Rsvp::Rules::Base) a single, top-level rule to perform
    #   all validation against.
    def initialize(rule)
      unless rule.is_a?(Rsvp::Rules::Base)
        throw "A schema must be created with a single, top-level rule."
      end
      @rule = rule
    end

    # Determines if a subject is valid or not, according to the schema.
    #
    # @param subject (Object) an arbitrary Ruby object to be validated against
    #   the schema.
    #
    # @return (true, false) returns `true` if the subject is valid according to
    #   the schema; returns `false` if it is invalid.
    def valid?(subject)
      @rule.accept?(subject)
    end
  end
end
