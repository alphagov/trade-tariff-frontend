class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    remove_column :chapters, :description
    add_column :chapters, :description, :text

    remove_column :commodities, :description
    add_column :commodities, :description, :text
  end
end
