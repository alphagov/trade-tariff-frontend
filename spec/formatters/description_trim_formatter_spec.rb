require 'spec_helper'
require 'description_trim_formatter'

describe DescriptionTrimFormatter do
  describe '.format' do
    it 'replaces | with empty space' do
      DescriptionTrimFormatter.format(description: '|').should == ' '
    end

    it 'strips !1!' do
      DescriptionTrimFormatter.format(description: '!1!').should == ''
    end

    it 'strips !X!' do
      DescriptionTrimFormatter.format(description: '!X!').should == ''
    end

    it 'strips !x!' do
      DescriptionTrimFormatter.format(description: '!x!').should == ''
    end

    it 'strips !o!' do
      DescriptionTrimFormatter.format(description: '!o!').should == ''
    end

    it 'strips !O!' do
      DescriptionTrimFormatter.format(description: '!O!').should == ''
    end

    it 'strips !>=!' do
      DescriptionTrimFormatter.format(description: '!>=!').should == ''
    end

    it 'strips !<=!' do
      DescriptionTrimFormatter.format(description: '!<=!').should == ''
    end

    it 'replaces  @<anycharacter> with <anycharacter>' do
      DescriptionTrimFormatter.format(description: '@1').should == '1'
    end

    it 'replaces $<anycharacter> with <anycharacter>' do
      DescriptionTrimFormatter.format(description: '$1').should == '1'
    end
  end
end
