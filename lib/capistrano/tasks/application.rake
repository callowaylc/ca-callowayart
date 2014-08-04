# author:      christian calloway callowaylc@gmail.com
# description: Defines capistrano tasks for application restart
# usage:       cap staging application:restart
#              


# application namespace definition
#####################################

namespace :application do
  desc <<-eod 
    Restart all application dependencies
  eod
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # restart all external services; order is important
      # here
      invoke 'unicorn:restart'
      invoke 'nginx:restart'
      invoke 'unicorn:restart'
    end
  end  
end

namespace :varnish do
  desc <<-eod 
    Restart transparent cache layer
  eod
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      capture :sudo, 'service varnish restart'
    end
  end 
end

namespace :nginx do
  desc <<-eod 
    Restart web server
  eod
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      capture :sudo, 'service nginx restart'
    end
  end 
end

namespace :unicorn do
  desc <<-eod 
    Restart rails server
  eod
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      within release_path do
        execute 'run/unicorn'
      end
    end
  end 
end

