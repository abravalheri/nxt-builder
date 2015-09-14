require 'spec_helper'

describe NxtBuilder::XML do
  describe ".register" do
    subject { NxtBuilder::XML }
    let(:tag) { :div }

    it { is_expected.to respond_to(:register) }

    context "before called" do
      it { is_expected.not_to have_method(tag) }
    end

    context "after called with :div" do
      before { NxtBuilder::XML.register(tag) }

      it { is_expected.to have_method(tag) }
    end

    context "when a tag corresponds to a existing method name" do
      let(:tag) { :__id__ }
      let(:error_class) { NxtBuilder::AlreadyDefinedMethod }

      specify { expect { subject.register(tag) }.to raise_error(error_class) }
    end

    context "with an array argument" do
      let(:tags) { [:span, :p] }

      before { NxtBuilder::XML.register(tags) }

      it "is expected to respond to all those tags" do
        tags.each { |t| is_expected.to have_method(t) }
      end
    end
  end

  describe ".document_class" do
    subject { NxtBuilder::XML.document_class }

    it { is_expected.to have_method(:fragment) }
    specify { expect(subject.new.fragment).to respond_to(:<<) }
  end
end
