require 'spec_helper'
require 'search_helper'

describe SearchHelper do
  include SearchHelper

  describe ".result_title" do
    context "search matched reference index" do
      let(:results) { stub(referenced_match?: true) }

      it 'returns heading with suggestions' do
        result_title(Section, results, "foo").should =~ /Suggested/
      end
    end

    context "search matched fuzzy index" do
      let(:results) { stub(referenced_match?: false) }

      it 'returns heading with contains' do
        result_title(Section, results, "foo").should =~ /contain/
      end
    end
  end
end
