def mock_user(options = {})
  options[:id] = "123456" unless options.key?(:id)
  options[:first_name] = "John" unless options.key?(:first_name)
  options[:last_name] = "Doe" unless options.key?(:last_name)
  options[:email] = "test@example.com" unless options.key?(:email)
  user = User.new(options)

  allow(user).to receive(:first_name).and_return(options[:first_name])
  allow(user).to receive(:last_name).and_return(options[:last_name])
  allow(user).to receive(:id).and_return(options[:id])
  allow(user).to receive(:email).and_return(options[:email])
  user
end
