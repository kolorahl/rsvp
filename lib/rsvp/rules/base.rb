module Rsvp::Rules
  # The base class for all rules. A "rule" is based on the Ruleification design
  # pattern, and treats the components of a schema definition as business rules.
  class Base
    def initialize(name)
      @name = name
    end

    # Returns the friendly name for the rule.
    #
    # @return (String) friendly name for the rule.
    def name
      @name
    end

    # Decide if the subject is accepted based on this business rule. This always
    # returns `false` until overwritten in a sub-class.
    #
    # @param subject (Object) the object to be used during rule testing.
    #
    # @return (true,false) returns `true` if the subject is accepted by this
    #   business rule; returns `false` if it is not accepted.
    def accept?(subject)
      false
    end
  end

  # A special kind of rule, this specification performs an AND operation between
  # the results of two separate rules. The rules themselves may be composites
  # like this one.
  class AndRule < Rsvp::Rules::Base
    # Constructs a composite rule that performs an AND (`&&`) operation on two
    # separate rules.
    #
    # @param one (Rsvp::Rules::Base) the rule to be used on the LHS.
    # @param two (Rsvp::Rules::Base) the rule to be used on the RHS.
    def initialize(one, two)
      unless one.is_a?(Rsvp::Rules::Base) && two.is_a?(Rsvp::Rules::Base)
        throw "The AndRule rule only accepts other rules as its parameters."
      end

      super("#{one.name} AND #{two.name}")
      @one = one
      @two = two
    end

    def accept?(subject)
      @one.accept?(subject) && @two.accept?(subject)
    end
  end

  # A special kind of rule, this specification performs an OR operation between
  # the results of two separate rules. The rules themselves may be composites
  # like this one.
  class OrRule < Rsvp::Rules::Base
    # Constructs a composite rule that performs an OR (`||`) operation on two
    # separate rules.
    #
    # @param one (Rsvp::Rules::Base) the rule to be used on the LHS.
    # @param two (Rsvp::Rules::Base) the rule to be used on the RHS.
    def initialize(one, two)
      unless one.is_a?(Rsvp::Rules::Base) && two.is_a?(Rsvp::Rules::Base)
        throw "The OrRule rule only accepts other rules as its parameters."
      end

      super("#{one.name} OR #{two.name}")
      @one = one
      @two = two
    end

    def accept?(subject)
      @one.accept?(subject) || @two.accept?(subject)
    end
  end

  # A special kind of rule, this specification performs a NOT operation on a
  # rule. The rule itself may be any kind of rule, including a composite such as
  # `AndRule` or `OrRule`.
  class NotRule < Rsvp::Rules::Base
    def initialize(rule)
      unless rule.is_a?(Rsvp::Rules::Base)
        throw "The NotRule only accepts a rule as its parameter."
      end

      super("NOT #{rule.name}")
      @rule = rule
    end

    def accept?(subject)
      @rule.accept?(subject)
    end
  end
end
