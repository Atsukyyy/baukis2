class ChangeDatatypeStartDateOfStaffMembers < ActiveRecord::Migration
  def change
    change_column :staff_members, :start_date, :date
  end
end
