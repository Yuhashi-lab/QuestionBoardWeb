class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.string :category
      t.string :detail
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
