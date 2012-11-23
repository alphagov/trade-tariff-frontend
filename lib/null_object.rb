# stub_attrs can be used to assign default values for method calls.
# Useful in cases where comparison with nil may occur.
class NullObject
  def initialize(stub_attrs = {})
    @stub_attrs = stub_attrs
  end

  def empty?; true; end
  def blank?; true; end

  def method_missing(*args, &block)
    method_name = args.first

    @stub_attrs.fetch(method_name, nil)
  end
end
