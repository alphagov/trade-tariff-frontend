RSpec::Matchers.define :have_attribute_superset_of do |expected|
  match do |actual|
    actual.map(&:attributes).any? { |attribute_set| compare_intersecting_keys(attribute_set, expected) }
  end

  def compare_intersecting_keys(a, b)
    a, b = a.with_indifferent_access, b.with_indifferent_access

    (a.stringify_keys.keys & b.stringify_keys.keys).all? {|k| a[k] == b[k]}
  end
end
