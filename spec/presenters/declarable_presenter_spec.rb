require 'spec_helper'

describe DeclarablePresenter do
  it 'relays all undefined methods to presented declarable object' do
    expect(
      DeclarablePresenter.new(Commodity.new(goods_nomenclature_item_id: "0102210000")).heading_code
    ).to eq("02")
  end
end
