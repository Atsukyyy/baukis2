class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object
  def suspended_mark
    suspended? ? view_context.raw('&#x2611;') :
      view_context.raw('&#x2610')
  end
end
