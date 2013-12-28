module Rsvp::Rules
  class Any < Rsvp::Rules::Base
    def initialize
      super('any')
    end

    # Always returns `true`.
    #
    # @param subject (Object) not used, as this rule passes any data.
    #
    # @return (true) always returns `true`.
    def accept?(subject)
      true
    end
  end
end
