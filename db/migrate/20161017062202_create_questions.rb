class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :questioner
      t.string :content
      t.text :answer
      t.references :board, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
