RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end

RSpec.configure do |config|
  unless config.files_to_run.one? || ENV["COVERAGE"] == "false"
    # When running a single spec, or a subset like spec/services, I don't want to
    # spend the extra time to check coverage. The first check skips SimpleCov in
    # the most frequent case of a single file, or use e.g. `fspec spec/services`:
    #     alias fspec="COVERAGE=false RAILS_ENV=test bundle exec rspec"
    require "simplecov"
    SimpleCov.start "rails" do
      # Allow for an isolated bundle without gemsets via `bundle install --path vendor/bundle`
      add_filter "/vendor/bundle"
    end
  end
end

require "benchmark"
require_relative "../config/environment"
require "rspec/rails"
require "rspec-rails"
require "selenium/webdriver"
require "shoulda/matchers"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = true
  config.order = "random"
  config.deprecation_stream = "log/deprecations.log"
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
end
