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

  desc 'trigger application restart after deployment'
  after :finished, :application do
    on roles(:web), in: :sequence, wait: 5 do
      invoke 'application:restart'
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
