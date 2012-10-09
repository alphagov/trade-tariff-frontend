if File.exists?("#{Rails.root}/REVISION")
  revision = `cat #{Rails.root}/REVISION`.chomp
  CURRENT_RELEASE_SHA = revision[0..7] # Just get the short SHA
else
  CURRENT_RELEASE_SHA = "development"
end
