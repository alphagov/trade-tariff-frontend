Dir[Rails.root.join("lib", "core_ext", "*.rb")].each do |extension|
  require extension
end
