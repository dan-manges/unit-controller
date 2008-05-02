require "rubygems"
gem "rails", ENV["RAILS_VERSION"] || ">= 2.0"
require "rails/version"
require "action_controller"
require "action_controller/test_process"

if Rails::VERSION::MAJOR == 2
  require "action_controller/test_case"
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require "unit_controller"

require "test/unit"
gem "dust", "0.1.6"
require "dust"
