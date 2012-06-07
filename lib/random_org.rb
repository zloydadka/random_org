require "rubygems"
require 'httparty'
require File.join(File.dirname(File.expand_path(__FILE__)), "version.rb")

module RandomOrg
  module VERSION
    MAGOR = 0
    MINOR = 2
    PATCH = 1
    FULL  = "#{MAGOR}.#{MINOR}.#{PATCH}"
  end

  class AbstractRandom
    include HTTParty
    base_uri 'http://www.random.org/'
    parser Proc.new { |body, format| body.split(/\s/) }
    
    protected
    def self.validate(value, param)
      raise "not valid" unless case param
                        when Regexp
                          value.to_s =~ param
                        when Array
                          param.map(&:to_s).include?(value.to_s)
                        end
    end
    
  end

end

require File.join(File.dirname(File.expand_path(__FILE__)), "integer.rb")

p RandomOrg::Integer.sequence
p RandomOrg::Integer.next
p RandomOrg::Integer.next(:base => 8)
