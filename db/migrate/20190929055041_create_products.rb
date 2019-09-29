class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name , null: false,index: true
      t.integer :price , null: false
      t.text  :detail , null: false
      t.integer :condition , null: false
      t.integer :delivery_tax_payer, null: false
      t.integer :delivery_agency , null: false
      t.integer :delivery_days , null: false
      t.integer :status , null: false
      t.references :user , null: false , foreign_key: true
      t.timestamps
    end
  end
end
