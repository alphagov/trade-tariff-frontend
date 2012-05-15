namespace :db do
  desc "Seed database with data"
  task seed: 'environment' do
    Rails.application.load_seed
  end

  desc "Populate database with fake test data"
  task populate: 'environment' do
    load(File.join(Rails.root, 'db', 'populates.rb'))
  end
end
