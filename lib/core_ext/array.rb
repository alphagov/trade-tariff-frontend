module ArrayPresenter
  def present_with(presenter_class)
    entries.map{|entry| presenter_class.new(entry) }
  end
end

Array.send :include, ArrayPresenter
