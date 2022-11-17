class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :birthdate
      t.string :gender
      t.string :address

      t.timestamps
    end
  end
end
