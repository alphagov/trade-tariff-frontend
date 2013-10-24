class MeasureChangePresenter < ChangePresenter
  def title
    "#{change_record.destination.capitalize} measure #{operation_name} for #{change.record.geographical_area}"
  end

  def content
    "'#{change_record.measure_type.description}' #{change_record.destination} measure #{operation_name} for #{change.record.geographical_area} on #{change.operation_date}"
  end

  def anchor_link
    "#{change_record.destination}-measure-#{change_record.id}"
  end
end
