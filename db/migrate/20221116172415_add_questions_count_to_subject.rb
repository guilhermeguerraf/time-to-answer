class AddQuestionsCountToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :questions_count, :integer, default: 0
  end
end
