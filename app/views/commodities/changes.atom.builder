atom_feed do |feed|
  feed.title("Trade Tariff - changes for #{@commodity.goods_nomenclature_item_id}: #{@commodity}")
  feed.updated(@changes.first.operation_date) if @changes.length > 0

  @changes.each do |change|
    feed.entry(
      change,
      id: "tag:#{request.host},2005:Change/#{change.id}",
      url: commodity_url(id: @commodity.goods_nomenclature_item_id, anchor: change.anchor_link)
    ) do |entry|
      entry.title(change.title)
      entry.content(change.content)
      entry.updated(change.operation_date.xmlschema)

      entry.author do |author|
        author.name("UK Trade Tariff")
      end
    end
  end
end
