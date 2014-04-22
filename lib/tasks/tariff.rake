require "tariff_diff"

namespace :tariff do
  desc "See what data is different between two app instances"
  task :diff, [:host1, :host2] do |t, args|
    # chapter is required
    # if the host requires authentication, set username and password to env
    # variables. eg:
    # rake tariff:diff[host1,host2] chapter=01 host1user=username host1passwd=secret host2user=username host2passwd=secret
    TariffDiff.new(args).run!
  end
end
