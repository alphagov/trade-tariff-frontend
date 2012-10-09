require 'spec_helper'
require 'description_trim_formatter'

describe DescriptionTrimFormatter do
  describe '.format' do
    it 'replaces | with empty space' do
      DescriptionTrimFormatter.format('|').should == ' '
    end

    it 'strips !1!' do
      DescriptionTrimFormatter.format('!1!').should == ''
    end

    it 'strips !X!' do
      DescriptionTrimFormatter.format('!X!').should == ''
    end

    it 'strips !x!' do
      DescriptionTrimFormatter.format('!x!').should == ''
    end

    it 'strips !o!' do
      DescriptionTrimFormatter.format('!o!').should == ''
    end

    it 'strips !O!' do
      DescriptionTrimFormatter.format('!O!').should == ''
    end

    it 'strips !>=!' do
      DescriptionTrimFormatter.format('!>=!').should == ''
    end

    it 'strips !<=!' do
      DescriptionTrimFormatter.format('!<=!').should == ''
    end

    it 'replaces  @<anycharacter> with <anycharacter>' do
      DescriptionTrimFormatter.format('@1').should == '1'
    end

    it 'replaces $<anycharacter> with <anycharacter>' do
      DescriptionTrimFormatter.format('$1').should == '1'
    end
  end
end
