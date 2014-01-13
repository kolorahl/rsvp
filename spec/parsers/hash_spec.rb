require 'spec/spec_helper'
require 'spec/parsers/shared_spec'

describe Rsvp::Parsers::Hash do
  context "with invalid schema input" do
    it_behaves_like "a parser with an invalid schema" do
      let(:parser) { Rsvp::Parsers::Hash.new({}) }
    end
  end

  context "with valid schema input" do
    it_behaves_like "a parser with a valid schema" do
      let(:parser) { Rsvp::Parsers::Hash.new({}) }
    end
  end
end
