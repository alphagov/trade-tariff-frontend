class ChangeSubstringToInteger < ActiveRecord::Migration
  def up
    change_column :commodities, :substring, :integer
  end

  def down
    change_column :commodities, :substring, :string
  end
end
