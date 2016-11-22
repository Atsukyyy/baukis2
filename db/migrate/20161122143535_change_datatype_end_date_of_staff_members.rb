class ChangeDatatypeEndDateOfStaffMembers < ActiveRecord::Migration
  def change
    change_column :staff_members, :end_date, :date
  end
end
