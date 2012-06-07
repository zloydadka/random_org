require "rubygems"
require 'httparty'


module RandomOrg
  module Services; end

  Dir[File.join(File.dirname(File.expand_path(__FILE__)), "services", "*.rb")].each { |file| load file }

  module Version
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


  Services.constants.each do |service_name|
    service = Services.const_get(service_name)
    kls = Class.new(AbstractRandom) 
    kls.send(:extend, service)
    kls.instance_eval { |_klass|
      parser service::PARSER
      base_uri(base_uri+service::RELATIVE_URL)
      
      alias :get_original :get
      
      def get(query = {})
        get_original("/", :query => query)
      end
      
    }
    const_set service_name, kls
  end
  remove_const("Services")
end



