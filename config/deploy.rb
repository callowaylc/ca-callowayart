#=============================================================================
# app details and WordPress requirements

# tags/3.5.1, branches/3.5, trunk
set :application, "showbizdaily.net"

#=============================================================================
# app source repository configuration

set :scm, :git
set :repo_url, "git@github.com:callowaylc/showbizdaily.git"
#set :git_enable_submodules, 1
#set :git_shallow_clone, 1

#=============================================================================
# Housekeeping
# clean up old releases on each deploy
set :keep_releases, 5
#set :ssh_options, { :forward_agent => true }

 # Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/ubuntu/Develop/showbizdaily'

# Default value for :scm is :git
set :scm,    :git

# set server user
set :user,   "ubuntu"

# deployment will be done via copy
set :deploy_via, :remote_cache

# only keep the last 5 releases
set :keep_releases, 5

#=============================================================================
# Additional Project specific directories

namespace :deploy do

  desc 'Restart application'
  desc 'Kick varnish'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')

      # restart unicorn server
      # desc 'kicking varnish tires'
      execute 'sudo service varnish restart'
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end  

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

# Uncomment these lines to additionally create your upload and cache
# directories in the shared location when running `deploy:setup`.
#
# Modify these commands to make sure these directories are writable by
# your web server.

# after "deploy:setup" do
#   ['uploads', 'cache'].each do |dir|
#     run "cd #{shared_path} && mkdir #{dir} && chgrp www-data #{dir} && chmod 775 #{dir}"
#   end
# end
