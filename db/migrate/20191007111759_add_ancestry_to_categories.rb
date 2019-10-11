class AddAncestryToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end

  def down
    remove_index :maincategories, :ancestry
    remove_column :maincategories, :ancestry
  end

  
end
