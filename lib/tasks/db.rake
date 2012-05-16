namespace :db do
  desc "Populate database with fake test data"
  task populate: 'environment' do
    load(File.join(Rails.root, 'db', 'populates.rb'))
  end
  desc "Import data"
  task import: 'environment' do
    load(File.join(Rails.root, 'db', 'import.rb'))
  end
end
