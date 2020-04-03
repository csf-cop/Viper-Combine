require 'thor'

class Exec < Thor
  class_option :verbose, :type => :boolean, :aliases => "-v"

  desc "install", "Install required gems, cocoapods"
  def install
    exec("bundle update")
    exec("bundle install")
    exec("bundle exec pod install")
  end

  desc "build PROJECT CONFIGURATION", "Build project with special configuration"
  def build(project, configuration)
    exec("xcodebuild -project #{project}/#{project}.xcodeproj -scheme #{project} -sdk iphoneos13.0 -configuration #{configuration} clean build")
  end

  desc "deploy PRODUCT TARGET", "Deploy PRODUCT to TARGET"
  def deploy(product, target)
    # ...
  end
end

Exec.start(ARGV)
