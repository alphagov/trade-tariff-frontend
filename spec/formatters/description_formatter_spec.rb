require 'spec_helper'
require 'description_formatter'

describe DescriptionFormatter do
  describe '.format' do
    it 'replaces | with non breaking space html entity' do
      DescriptionFormatter.format(' | ').should == ' &nbsp; '
    end

    it 'replaces !1! with breaking space tags' do
      DescriptionFormatter.format(' !1! ').should == ' <br /> '
    end

    it 'replaces !X! with times html entity' do
      DescriptionFormatter.format(' !X! ').should == ' &times; '
    end

    it 'replaces !x! with times html entity' do
      DescriptionFormatter.format(' !x! ').should == ' &times; '
    end

    it 'replaces !o! with deg html entity' do
      DescriptionFormatter.format(' !o! ').should == ' &deg; '
    end

    it 'replaces !O! with deg html entity' do
      DescriptionFormatter.format(' !O! ').should == ' &deg; '
    end

    it 'replaces !>=! with greater or equals html entity' do
      DescriptionFormatter.format(' !>=! ').should == ' &ge; '
    end

    it 'replaces !<=! with less or equal html entity' do
      DescriptionFormatter.format(' !<=! ').should == ' &le; '
    end

    it 'replaces and wraps @<anycharacter> with html sub tag' do
      DescriptionFormatter.format(' @1 ').should == ' <sub>1</sub> '
    end

    it 'replaces and wraps $<anycharacter> with html sup tag' do
      DescriptionFormatter.format(' $1 ').should == ' <sup>1</sup> '
    end
  end
end
