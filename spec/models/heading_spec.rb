require 'spec_helper'

describe Heading do
  it { should have_many(:commodities) }
  it { should belong_to(:chapter) }
end
