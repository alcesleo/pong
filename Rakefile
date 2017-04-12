require "rake/testtask"
Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.libs << "spec"
  t.warning = false
end

require "rubocop/rake_task"
RuboCop::RakeTask.new(:style)

task default: %i[test style]
