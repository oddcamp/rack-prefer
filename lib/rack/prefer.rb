require "rack/prefer/version"

module Rack
  module Prefer
    class PreferPresenter
      attr_reader :values

      def initialize(req)
        @values = CGI.parse(
          (req.env['HTTP_PREFER'] || '').gsub(',','&').gsub(' ','')
        )
        @values = {} if !@values.is_a?(Hash)
        @values.each{|k,v| @values[k] = v.first}
        if Object.const_defined?(:HashWithIndifferentAccess)
          @values = HashWithIndifferentAccess.new(@values)
        end
      end

      def wait?
        @values.key?('wait')
      end

      def wait
        @values['wait'].to_i
      end

      def respond_async?
        @values.key?('respond-async')
      end

      def return
        @values['return']
      end

      def return_representaton?
        @values['return'] == 'representation'
      end

      def return_minimal?
        @values['return'] == 'minimal'
      end

      def handling
        @values['handling']
      end

      def handling_strict?
        @values['handling'] == 'strict'
      end

      def handling_lanient?
        @values['handling'] == 'lanient'
      end
    end
  end
end

class Rack::Request
  def prefer
    @prefer_presenter ||= Rack::Prefer::PreferPresenter.new(self)
  end
end
