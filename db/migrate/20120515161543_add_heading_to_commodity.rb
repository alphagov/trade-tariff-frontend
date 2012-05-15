class AddHeadingToCommodity < ActiveRecord::Migration
  def change
    add_column :commodities, :heading, :boolean, default: false
    remove_column :chapters, :number
    add_column :chapters, :code, :string
  end
end
