# Simple Role Syntax
# ==================
set :branch, 'feature/submission'
set :stage,  'production'

# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
#role :app, %w{deploy@example.com}
role :web, %w{ ubuntu@web0 } 