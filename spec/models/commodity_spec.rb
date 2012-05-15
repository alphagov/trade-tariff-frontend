require 'spec_helper'

describe Commodity do
  it { should belong_to(:chapter) }
end
