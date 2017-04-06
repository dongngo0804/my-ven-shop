set :application, "VenShop"
set :repo_url, "git@github.com:dongngo0804/my-ven-shop.git"

set :deploy_to, '/home/deploy/VenShop'

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"