set :application, "venshop"
set :repo_url, "git@github.com:dongngo0804/my-ven-shop.git"
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

set :deploy_to, '/home/deploy/venshop'

append :linked_files, "config/database.yml", "config/secrets.yml" "config/application.yml" "config/sunspot.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"


