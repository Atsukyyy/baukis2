class ChangeDatatypeSuspendedOfStaffMembers < ActiveRecord::Migration
  def change
    change_column :staff_members, :suspended, :boolean
  end
end
