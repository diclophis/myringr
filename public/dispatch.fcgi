#!/usr/bin/ruby

require ENV['COMP_ROOT'] + "/myringr"
require ENV['COMP_ROOT'] + "/boot"

Rack::Handler::FastCGI.run(Myringr)
