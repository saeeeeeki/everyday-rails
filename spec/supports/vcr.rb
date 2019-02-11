require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "#{::Rails.root}/spec/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.filter_sensitive_data('Secret') { 'Accept-Encoding' }
  config.default_cassette_options = { record: :new_episodes, :re_record_interval => 7.days }
end
