require 'spec_helper'

describe NxtBuilder::HTML do
  it { is_expected.to respond_to(*NxtBuilder::HTML::TAGS) }

  describe "#_tag" do
    context "when called with a data attribute hash" do
      it "should flatten" do
        expect(subject._tag(:p, data: { a: 1 }).to_s).to start_with('<p data-a="')
      end
    end

    context "when called with a boolean attribute" do
      context "when attribute is false" do
        let!(:result) { subject._tag(:input, disabled: false).to_s }

        it "should remove attribute" do
          expect(result).not_to include('disabled')
        end
      end

      context "when attribute is true" do
        let!(:result) { subject._tag(:input, disabled: true).to_s }

        it "should include attribute" do
          expect(result).to include('disabled')
        end
      end
    end
  end

  describe "#render!" do
    it "should output idented nodes" do
      response = subject.render! do |r|
        r.html! do
          r.head { r.title "Test" }
        end
      end.to_s

      expectation = <<-EOS.gsub(/^\s{8}/, '').strip
        <!DOCTYPE html>
        <html>
          <head>
            <title>Test</title>
          </head>
        </html>
      EOS

      expect(response.strip).to eq(expectation)
    end
  end
end
