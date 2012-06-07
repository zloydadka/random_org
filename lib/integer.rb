module RandomOrg
  class Integer < AbstractRandom
    parser Proc.new { |body, format| body.split(/\s/).map &:to_i }
    class << self
      def next(options = {})
        sequence(options.merge({:num => 1})).first
      end

      def sequence(options = {})
        permanent_options = {
          :format => :plain
        }
        query = {
          :min => 1,
          :max => 100,
          :base => 10,
          :num => 3,
          :col => 1
        }.merge(options).merge(permanent_options)

        validate(query[:base], [2,8,10,16])

        response = self.get("/integers/", :query => query)
        raise "Error: #{response.code}" if response.code != 200
        response.parsed_response
      end
    end
  end
end