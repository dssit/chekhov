class User < ActiveRecord::Base
  using_access_control
  
  validates_presence_of :loginid, :rm_id, :email
  
  def role_symbols
    # ||= 'trick' to avoid multiple RM fetches per worker instance
    # (_should_ reload from RolesManagement on page load)
    @role_symbols ||= RolesManagement.fetch_role_symbols_by_loginid(loginid)
  end
end
