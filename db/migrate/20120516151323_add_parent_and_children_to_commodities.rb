class AddParentAndChildrenToCommodities < ActiveRecord::Migration
  def up
    remove_column :commodities, :heading
    add_column :commodities, :is_heading, :boolean, :default => false
    add_column :commodities, :heading_id, :integer

    add_index :commodities, :heading_id
  end

  def down
    remove_column :commodities, :is_heading
    add_column :commodities, :heading, :boolean

    remove_column :commodities, :heading_id

    remove_index :commodities, :heading_id
  end
end
