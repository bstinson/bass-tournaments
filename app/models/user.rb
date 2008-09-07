class User < ActiveRecord::Base
  
  # Creates a temporary variable that can be used when changing a user's password.
  attr_accessor :confirm_password

  def clear_password!
    self.password = nil
    self.confirm_password = nil
  end  
end
