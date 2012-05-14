namespace :db do
  desc "Seed database with data"
  task seed: 'environment' do
    Rails.application.load_seed
  end
end
