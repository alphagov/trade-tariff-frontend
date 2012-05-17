namespace :db do
  desc "Populate database with fake test data"
  task populate: 'environment' do
    load(File.join(Rails.root, 'db', 'populates.rb'))
  end
  desc "Import XLS data"
  task import: 'environment' do
    load(File.join(Rails.root, 'db', 'import.rb'))
  end
  desc "Scrape Site"
  task scrape: 'environment' do
    load(File.join(Rails.root, 'db', 'scrape.rb'))
  end
end
