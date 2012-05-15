class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references   :section
      t.integer      :number
      t.string       :description
      t.timestamps
    end
  end
end
