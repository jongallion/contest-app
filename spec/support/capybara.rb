require "capybara/rspec"

Capybara.server = :webrick
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless
# Capybara.javascript_driver = :selenium_chrome

RSpec.configure do |config|
  config.around(:each, type: :system) do |example|
    driven_by Capybara.javascript_driver
    cached_app_url = ENV["APP_URL"]
    ENV["APP_URL"] = "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
    example.run
    ENV["APP_URL"] = cached_app_url
  end
end
