class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'
  alias_attribute :accured_at, :created_at
end
