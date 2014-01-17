class CommodityPresenter < DeclarablePresenter
  def show_commodity_tree?
    true
  end

  def link
    view_context.commodity_path(declarable)
  end
end
