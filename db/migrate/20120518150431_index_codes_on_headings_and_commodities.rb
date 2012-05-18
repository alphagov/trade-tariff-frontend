class IndexCodesOnHeadingsAndCommodities < ActiveRecord::Migration
  def up
    add_index :commodities, :code
    add_index :headings, :code
  end

  def down
    remove_index :commodities, :code
    remove_index :headings, :code
  end
end
