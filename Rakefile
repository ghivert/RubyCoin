require "fileutils"
require "dotenv/tasks"

namespace :server do
  desc "Launch the development server"
  task :run do
    sh("bundle exec inesita server")
  end
end

namespace :build do
  desc "Build the app"
  task :app do
    sh("bundle exec inesita build -f true")
  end

  desc "Build and deploy the app to Azure"
  task deploy: [:app, :dotenv] do
    FileUtils.cd('dist') do
      sh("zip -r dist.zip .")
      sh("az webapp deployment source config-zip --resource-group #{ENV["RESOURCE_GROUP"]} --name #{ENV["NAME"]} --src dist.zip")
      sh("rm dist.zip")
    end
  end
end
