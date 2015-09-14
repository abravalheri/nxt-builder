require 'spec_helper'

describe NxtBuilder::XML do
  subject { NxtBuilder::XML.new }

  describe "#_tag" do
    before { subject.clear_buffer! }
    let!(:result) { subject._tag(:div) }

    specify { expect(result).to respond_to(:to_s) }
    specify { expect(result.to_s).to be_xml }

    it "should keep inner buffer empty" do
      expect(subject.to_s).to be_empty
    end
  end

  describe "#tag!" do
    before { subject.clear_buffer! }
    let!(:result) { subject.tag!(:div) }

    it "should populate inner buffer" do
      expect(subject.to_s).to eq(result.to_s)
    end

    context "when called with a block" do
      let(:result) { subject.tag!(:a) { subject.tag!("b") }.to_s.split.join }
      # split + join => remove identation

      it "should nest tags" do
        expect(result).to eq("<a><b/></a>")
      end
    end
  end

  describe "#text!" do
    it "should populate inner buffer" do
      subject.text!("text")
      expect(subject.to_s).to eq("text")
    end

    it "should escape characters" do
      subject.text!("<a/>")
      expect(subject.to_s).not_to include('<')
    end
  end

  describe "#raw!" do
    it "should populate inner buffer" do
      subject.raw!("text")
      expect(subject.to_s).to eq("text")
    end

    it "should not escape characters" do
      subject.raw!("<a/>")
      expect(subject.to_s).to include('<')
    end
  end

  describe "#_parse" do
    before { subject.clear_buffer! }

    it "should keep inner buffer empty" do
      subject._parse('<a/>')
      expect(subject.to_s).to be_empty
    end

    it "should be equivalent to _tag" do
      expect(subject._parse('<a/>').to_s).to eq(subject._tag(:a).to_s)
    end
  end
end


  # before do
  #   unless NxtBuilder::XML.method_defined?(:div)
  #     NxtBuilder::XML.register(:div)
  #   end
  # end
