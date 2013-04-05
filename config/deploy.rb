set :stages, %w(production staging)     #various environments
load "deploy/assets"                    #precompile all the css, js and images... before deployment..
require "bundler/capistrano"            # install all the new missing plugins...
require 'capistrano/ext/multistage'     # deploy on all the servers..
require 'delayed/recipes'               # load this for delayed job..
require "rvm/capistrano"                # if you are using rvm on your server..
require './config/boot'           
#require 'airbrake/capistrano'           # using airbrake in your application for crash notifications..
#require 'thinking_sphinx/deploy/capistrano' 
set :delayed_job_args, "-n 2" 

before "deploy:assets:precompile","deploy:copy_database_file"
after "deploy:update", "deploy:cleanup" #clean up temp files etc.
after "deploy:update_code","deploy:migrate"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user


#server "69.164.208.79", :app, :web, :db, :primary => true
server "192.155.90.129", :app, :web, :db, :primary => true  


set(:application) { "social_media" }
set (:deploy_to) { "/home/fizzy/#{application}/#{stage}" }
set :user, 'fizzy'
set :keep_releases, 3
set :repository, "git@bitbucket.org:fizzysoftware/social_content_managment.git"
set :use_sudo, false
set :scm, :git
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1



namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end



  # desc "invoke the db migration"
  # task:migrate, :roles => :app do
  #   send(run_method, "cd #{current_path} && rake db:migrate RAILS_ENV=#{stage} ")
  # end

  task:stop_delayed_job, :roles=>:app do
    send(run_method, "cd #{current_path} && RAILS_ENV=#{stage}  script/delayed_job stop ")
  end   


  task:start_delayed_job, :roles=>:app do
    send(run_method, "cd #{current_path} && RAILS_ENV=#{stage}  script/delayed_job -n 2 start ") 
  end


  desc "Deploy with migrations"
  task :long do
    #stop_delayed_job
    transaction do      
      update_code
      #web.disable
      symlink
      copy_database_file
      migrate
      
    end
    start_delayed_job
   # copy_htaccess_file
    restart
    #web.enable
    cleanup
  end

  task :copy_database_file, :roles => :app do
    #run "cp #{shared_path}/database.yml #{current_path}/config/database.yml"
    run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  task :copy_htaccess_file, :roles => :app do
    run "cp #{shared_path}/.htaccess #{current_path}/public/.htaccess"
  end
  

  desc "Run cleanup after long_deploy"
  task :after_deploy do
    cleanup
  end

end

