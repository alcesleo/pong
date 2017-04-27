require "rubocop/rake_task"
RuboCop::RakeTask.new(:style)

task default: :style

desc "Updates the pkg/Pong.app file"
task :release do
  destination = "pkg/Pong.app/Contents/Resources"

  rm File.join(destination, "main.rb")
  rm_r File.join(destination, "app")

  cp("main.rb", destination)
  cp_r("app", destination)
end
