VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<PIVOTAL_TOKEN>') {
    ENV.fetch('PIVOTAL_TOKEN', 'token-not-specified')
  }
end
