class CreateStaffMembers < ActiveRecord::Migration
  def change
    create_table :staff_members do |t|
      t.string :email, null: false
      t.string :email_for_index, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :hashed_password
      t.string :start_date, null: false
      t.string :end_date
      t.string :suspended, null: false, default: false

      t.timestamps
    end

    add_index :staff_members, :email_for_index, unique: true
    add_index :staff_members, [ :family_name_kana, :given_name_kana ]
  end
end
