# frozen_string_literal: true
guard :minitest, spring: true, all_on_start: false do
  watch(%r{^app/(.*)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.*)_controller\.rb$}) do |m|
    "test/controllers/#{m[1]}_test.rb"
  end
  watch('config/routes.rb') { 'test/controllers' }
  watch(%r{^app/models/(.*)\.rb}) { |m| "test/models/#{m[1]}_test.rb" }

  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^test/controllers/(.*)_controller_test\.rb$}) do |m|
    "test/controllers/#{m[1]}_controller_test.rb"
  end
  watch(%r{^test/models/(.*)_test\.rb$}) { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
