class AddContest < ActiveRecord::Migration[5.2]
  def change
    create_table :contest_entries do |t|
      t.string :user_id
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps

      t.index :created_at, name: "idx_contest_entry_create_date"
    end
  end
end
