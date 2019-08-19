# first run rubocop and auto fix all the styling issues
# and then run the tests

guard :minitest, all_on_start: false, spring: 'bin/rails test -d --profile' do
  # with Minitest::Unit
  watch(%r{^app/(.+)\.rb$}) do |m|
    dirname = File.dirname("test/#{m[1]}_test.rb")
    filename = File.basename("test/#{m[1]}")
    Dir.glob("#{dirname}/*.rb").select do |entry|
      /#{filename}(\..+)?_test.rb/ =~ entry
    end
  end
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { 'test' }
end

guard :rubocop, all_on_start: false, cli: ['--format', 'clang', '--rails', '-a'] do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
