class MeasureChangePresenter < ChangePresenter
  def title
    "#{change_record.destination.capitalize} measure #{operation_name} for #{change.record.geographical_area}"
  end

  def content
    "'#{change_record.measure_type_description}' #{change_record.destination} measure #{operation_name} for #{change.record.geographical_area} on #{change.operation_date}"
  end

  def anchor_link
    "#{change_record.destination}-measure-#{change_record.measure_sid}"
  end
end
