if File.exists?("#{Rails.root}/REVISION")
  revision = `cat #{Rails.root}/REVISION`.chomp
  CURRENT_RELEASE_SHA = revision
else
  CURRENT_RELEASE_SHA = "development"
end
