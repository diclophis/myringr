#!/usr/bin/ruby

require 'uri'
require 'ftools'
require 'rubygems'
require 'RMagick'
include Magick
require 'time'
require 'timeout'
require 'open3'
require 'digest/md5'
require 'daemons'
require 'drb'
require 'uuidtools'
require 'camping'

Camping.goes :Myringr

module Myringr
end

module Myringr::Models
  class Base
    def Base.table_name_prefix
    end
  end

  class CreateMyringr < V 1 
    def self.up
      create_table(:connections, :force => true) { |t|
        t.column :name, :string, :limit => 80, :null => false
        t.column :host, :string, :limit => 31, :null => false, :default => 'dynamic'
        t.column :nat, :string, :limit => 5, :null => false, :default => 'no'
        t.column :type, :string, :limit => 6, :null => false, :default => 'friend'
        t.column :accountcode, :string, :limit => 20, :null => true, :default => nil
        t.column :amaflags, :string, :limit => 13, :null => true, :default => nil
        t.column :callgroup, :string, :limit => 10, :null => true, :default => nil
        t.column :callerid, :string, :limit => 80, :null => true, :default => nil
        t.column :cancallforward, :string, :limit => 3, :null => false, :default => 'yes'
        t.column :canreinvite, :string, :limit => 3, :null => false, :default => 'no'
        t.column :context, :string, :limit => 80, :null => true, :default => nil
        t.column :defaultip, :string, :limit => 15, :null => true, :default => nil
        t.column :dtmfmode, :string, :limit => 7, :null => false, :default => 'rfc2833'
        t.column :fromuser, :string, :limit => 80, :null => true, :default => nil
        t.column :fromdomain, :string, :limit => 80, :null => true, :default => nil
        t.column :insecure, :string, :limit => 4, :null => true, :default => nil
        t.column :language, :string, :limit => 2, :null => true, :default => nil
        t.column :mailbox, :string, :limit => 50, :null => true, :default => nil
        t.column :md5secret, :string, :limit => 80, :null => true, :default => nil
        t.column :deny, :string, :limit => 95, :null => true, :default => nil
        t.column :permit, :string, :limit => 95, :null => true, :default => nil
        t.column :mask, :string, :limit => 95, :null => true, :default => nil
        t.column :musiconhold, :string, :limit => 100, :null => true, :default => nil
        t.column :pickupgroup, :string, :limit => 10, :null => true, :default => nil
        t.column :qualify, :string, :limit => 3, :null => false, :default => 'yes'
        t.column :regexten, :string, :limit => 80, :null => true, :default => nil
        t.column :restrictcid, :string, :limit => 3, :null => true, :default => nil
        t.column :rtptimeout, :string, :limit => 3, :null => true, :default => nil
        t.column :rtpholdtimeout, :string, :limit => 3, :null => true, :default => nil
        t.column :secret, :string, :limit => 80, :null => true, :default => nil
        t.column :setvar, :string, :limit => 100, :null => true, :default => nil
        t.column :disallow, :string, :limit => 100, :null => true, :default => 'all'
        t.column :allow, :string, :limit => 100, :null => true, :default => 'g729;ilbc;gsm;ulaw;alaw'
        t.column :fullcontact, :string, :limit => 80, :null => false, :default => ''
        t.column :ipaddr, :string, :limit => 15, :null => false, :default => ''
        t.column :port, :string, :limit => 5, :null => false, :default => '0'
        t.column :regseconds, :int, :limit => 11, :null => false, :default => 0
        t.column :username, :string, :limit => 80, :null => false, :default => ''
        t.column :useragent, :string, :limit => 255, :null => true
      }
    end
  end

  class Listing < Base
  end

  class Call < Base
  end

  class Voicemail < Base
  end

  class Fax < Base
  end
end

module Myringr::Controllers
  class Dashboard < R("/dashboard")
    def get
      @most_active_listings = []
      @lastest_calls = []
    end
  end

  class Listings < R("/listings")
    def get
      @listings = []
    end
  end

  class CreateOrUpdateListing < R("/listing/(\d+)")
    def get (listing_id = nil)
      @listing = nil
    end
  end

  class Report < R("/report")
    def get
      @begin_date = nil
      @end_date = nil
    end
  end

  class Voicemails < R("/voicemails")
    def get
      @voicemails = []
    end
  end

  class Faxes < R("/faxes")
    def get
      @faxes = []
    end
  end

  class Notifications < R("/notifications")
    def get
    end
  end

  class Account < R("/account")
    def get
    end
  end
end

module Myringr::Views
  def layout
    xhtml_transitional {
      head {
        title {
          "myringr"
        }
      }
      body {
        yield
      }
    }
  end
end
