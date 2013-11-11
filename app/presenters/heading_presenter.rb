class HeadingPresenter < DeclarablePresenter
  def show_commodity_tree?
    false
  end

  def link
    view_context.heading_path(declarable)
  end
end
