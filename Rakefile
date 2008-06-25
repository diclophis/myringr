require 'rubygems'
require 'rake'
require '/var/www/myringr/myringr'
require '/var/www/myringr/boot'
 
desc "Default Task"
task :default => [ :migrate ]

desc "Migrate"
task :migrate do
  puts "migrating..."
  Myringr::Models.create_schema
end
