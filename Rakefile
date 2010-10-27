namespace :server do

  desc "Starts server"
  task :start do
    sh "rackup --pid rackup.pid &"
  end

  desc "Stops server"
  task :stop do
    sh "kill -INT `cat rackup.pid`"
  end

end
