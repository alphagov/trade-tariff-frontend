govuk_defaults = '/etc/govuk/unicorn.rb'
instance_eval(File.read(govuk_defaults), govuk_defaults) if File.exist?(govuk_defaults)

app_root = File.dirname(File.dirname(__FILE__))
working_directory app_root
worker_processes 4
