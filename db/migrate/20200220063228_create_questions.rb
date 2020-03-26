class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :category
      t.string :url

      t.timestamps
    end
  end
end
