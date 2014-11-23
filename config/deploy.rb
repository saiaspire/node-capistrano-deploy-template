set :application, "MY_APPLICATION"
set :repository, "git@github.com:PATH_TO_MY_REPO"
set :scm, :git
set :use_sudo, false
set :keep_releases, 5
set :deploy_via, :remote_cache
set :main_js, "app.js"
 
desc "Setup the Dev Env"
task :dev do
   set :branch, 'develop'
   set :domain, 'MY DEV SERVER'
   set :user, 'MY SSH USER'
   set :applicationdir, "/home/#{user}/deploy/#{application}"
   set :deploy_to, applicationdir
   ssh_options[:keys] = ["/path/to/my/ssh.pub"]
 
   server 'MY DEV SERVER', :app, :web, :db, :primary => true
end
 
desc "Setup the Production Env"
task :production do
  set :branch, 'master'
  set :domain, 'MY PROD SERVER'
  set :user, 'MY SSH USER'
  set :applicationdir, "/home/#{user}/deploy/#{application}"
  set :deploy_to, applicationdir

  server 'MY PROD SERVER', :app, :web, :db, :primary => true
end

namespace :deploy do

  before 'deploy:start', 'deploy:npm_install'
  before 'deploy:restart', 'deploy:npm_install'

  after 'deploy:create_symlink', 'deploy:symlink_node_folders'
  after 'deploy:setup', 'deploy:node_additional_setup'

  desc "START the servers"
    task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{applicationdir}/current/ && forever start #{main_js}"
  end

  desc "STOP the servers"
    task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{applicationdir}/current/ && forever stop #{main_js}"
  end

  desc "RESTART the servers"
    task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{applicationdir}/current/ && forever restart #{main_js}"
  end

  task :symlink_node_folders, :roles => :app, :except => { :no_release => true } do
    run "ln -s #{applicationdir}/shared/node_modules #{applicationdir}/current/node_modules"
  end

  task :node_additional_setup, :roles => :app, :except => { :no_release => true } do
    run "mkdir -p #{applicationdir}/shared/node_modules"
  end

  task :npm_install, :roles => :app, :except => { :no_release => true } do
    run "cd #{applicationdir}/current/ && npm install"
  end

  task :npm_update, :roles => :app, :except => { :no_release => true } do
    run "cd #{applicationdir}/current/ && npm update"
  end
end