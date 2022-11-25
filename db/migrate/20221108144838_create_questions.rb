class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.references :subject, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
