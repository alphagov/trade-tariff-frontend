class AddSectionModel < ActiveRecord::Migration
  def up
    remove_column :commodities, :is_heading
    remove_column :commodities, :chapter_id

    create_table :headings do |t|
      t.references  :chapter
      t.string      :description
      t.integer     :hier_pos
      t.string      :substring
      t.string      :code
      t.timestamps
    end
  end

  def down
    add_column :commodities, :is_heading, :boolean
    add_column :commodities, :chapter_id, :integer

    drop_table :headings
  end
end
