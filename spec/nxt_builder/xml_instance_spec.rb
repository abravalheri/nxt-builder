require 'spec_helper'

describe NxtBuilder::XML do
  describe "#_tag" do
    before { subject.clear_buffer! }
    let!(:result) { subject._tag(:div) }

    it "should produce valid xml" do
      expect(result).to respond_to(:to_s)
      expect(result.to_s).to be_xml
    end

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
    before { subject.clear_buffer! && subject.raw!("<a/>") }
    let!(:buffer_state) { subject.to_s }

    it "should populate inner buffer" do
      expect(buffer_state).to eq("<a/>")
    end

    it "should not escape characters" do
      expect(buffer_state).to include('<')
    end
  end

  describe "#_parse" do
    before { subject.clear_buffer! }
    let!(:node) { subject._parse('<a/>').to_s }
    let!(:buffer_state) { subject.to_s }

    it "should keep inner buffer empty" do
      expect(buffer_state).to be_empty
    end

    it "should be equivalent to _tag" do
      expect(node).to eq(subject._tag(:a).to_s)
    end
  end
end
