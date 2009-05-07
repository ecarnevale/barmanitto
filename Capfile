load 'deploy' if respond_to?(:namespace)

set :application, "barmanitto.com"
set :repository,  "git@github.com:mikamai/barmanitto.git"
set :deploy_to,   "/var/apps/#{application}"

set :scm,               :git
set :branch,            "master"
set :repository_cache,  "git_master_branch"
set :deploy_via,        :remote_cache

set :user, 		'rails'
set :use_sudo, false  
set :runner, 	'rails'

role :app, "barmanitto.com:8888"
role :web, "barmanitto.com:8888"
role :db,  "barmanitto.com:8888", :primary => true


namespace :deploy do
	after "deploy:symlink", "deploy:bar_manitto:symlink"
	
	task :finalize_update, :except => { :no_release => true } do
  end
   
	namespace :bar_manitto do
		task :symlink do
		  %w[tmp db].each do |folder|
		    run "cd #{shared_path}; mkdir -p #{folder}; cd #{current_path}; rm -rf #{folder}; ln -s #{shared_path}/#{folder} #{folder}"
	    end
		end
	end	
end

deploy.task :restart, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end

deploy.task :start, :roles => :app do
  # nothing to do here
end

deploy.task :stop, :roles => :app do
  # nothing to do here
end