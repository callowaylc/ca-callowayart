#=============================================================================
# app details and WordPress requirements

# tags/3.5.1, branches/3.5, trunk
set :application, 'callowayart.com'
set :repo_url,    'git@github.com:callowaylc/ca-callowayart.git'
set :scm,         :git

#=============================================================================
# app source repository configuration

set :keep_releases, 3
set :user,          'ubuntu'
set :use_sudo,      true
set :pty,           true
set :format,        :pretty
set :log_level,     :info
set :deploy_via,    :remote_cache
set :deploy_to,     '/releases'


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

  desc 'Kick unicorn'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')

      # restart unicorn server
      # desc 'kicking varnish tires'
      #execute 'rm -rf tmp/pids/*'
      #execute 'rails s &'
    end
  end

  desc 'Kick nginx'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')

      # restart unicorn server
      # desc 'kicking varnish tires'
      execute 'sudo service nginx restart'
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
    #on roles(:web), in: :groups, limit: 3, wait: 10 do
    on roles(:web), in: :sequence, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      root  = '/app/callowyart'
      execute "ln -s ~/Develop/ca-callowayart/tmp #{root}/tmp"

      begin
        execute "cat tmp/pids/server.pid`; rails server -d -p 8080"
      rescue 
        execute "cd #{root} && nohup rails s &"
      end
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
