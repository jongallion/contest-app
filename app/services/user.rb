class User
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include ActionView::Helpers
# This class is just a mock to allow ContestEntry to work.

  attr_accessor :id, :first_name, :last_name, :email

end
