class CreateQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaires do |t|
      t.integer :question_id
      t.string :option1
      t.string :option2

      t.timestamps
    end
  end
end
