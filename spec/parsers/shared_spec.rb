require 'spec/spec_helper.rb'

shared_examples "a parser with an invalid schema" do
  describe "#generate" do
    let(:result) { parser.generate }

    it "should return nil" do
      expect(parser.generate).to be_nil
    end
  end

  describe "#errors" do
    it "should return a non-empty list of errors" do
      expect(parser.errors).to_not be_empty
    end
  end
end

shared_examples "a parser with a valid schema" do
  describe "#generate" do
    let(:result) { parser.generate }

    it "should return an instance of Rsvp::Schema" do
      expect(result).to be_instance_of(Rsvp::Schema)
    end
  end
end
