require 'spec_helper'

describe 'common rails tasks should pass', :slow do
  before { Uktt::Application.load_tasks }

  # TODO keep this out for a while, too slow
  # it 'bundle exec rake db:seed' do
  #   lambda {  Rake::Task['db:seed'].invoke }
  #     .should_not raise_error
  # end

  it 'bundle exec rake db:populate' do
    lambda {  Rake::Task['db:populate'].invoke }
      .should_not raise_error
  end
end
