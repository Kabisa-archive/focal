def fixture_file(filename)
  filepath = File.expand_path(File.join(Rails.root, 'spec', 'fixtures', filename))
  File.new(filepath)
end