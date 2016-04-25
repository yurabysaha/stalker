module ApplicationHelper
  def avatar(id)
    UserItem.find(id).avatar
  end
end
