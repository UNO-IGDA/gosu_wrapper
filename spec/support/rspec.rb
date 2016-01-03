# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.disable_monkey_patching!
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.filter_run :focus

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.profile_examples = 10
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.warnings = true

  Kernel.srand config.seed
end
