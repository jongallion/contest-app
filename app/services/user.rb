class User
  include ActiveModel::Model
  # This class is just a mock to allow ContestEntry to work.

  attr_accessor :id, :first_name, :last_name, :email

end
