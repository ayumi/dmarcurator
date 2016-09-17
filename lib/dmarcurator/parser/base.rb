# frozen_string_literal: true
require "open3"
require "ox"

module Dmarcurator
  module Parser
    # Base XML parser
    class Base
      attr_reader :doc

      def initialize(xml: nil, parsed_xml: nil)
        if xml
          content = File.read(xml)
          @doc = Ox.parse(content)
        elsif parsed_xml
          @doc = parsed_xml
        else
          raise "Either :xml or :parsed_xml are required"
        end
      end
    end
  end
end
