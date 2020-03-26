class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :sentence
      t.integer :questionnaire_number

      t.timestamps
    end
  end
end
