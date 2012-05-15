class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.references  :chapter
      t.string      :description
      t.integer     :hier_pos
      t.string      :substring
      t.string      :code
      t.timestamps
    end
  end
end
