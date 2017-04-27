require "rubocop/rake_task"
RuboCop::RakeTask.new(:style)

task default: :style

desc "Package both the .app and the .zip files"
task release: %i[app zip]

desc "Updates the pkg/Pong.app file"
task :app do
  destination = "pkg/Pong.app/Contents/Resources"

  rm File.join(destination, "main.rb")
  rm_r File.join(destination, "app")

  cp("main.rb", destination)
  cp_r("app", destination)
end

desc "Package the pkg/Pong.app file as a zip"
task :zip do
  Dir.chdir("pkg") do
    sh "zip -r Pong.zip Pong.app/"
  end
end
