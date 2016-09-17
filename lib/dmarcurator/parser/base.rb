# frozen_string_literal: true
require "open3"
require "ox"

module Dmarcurator
  module Parser
    # Base XML parser
    class Base
      attr_reader :doc

      def initialize(xml:)
        content = File.read(xml)
        @doc = Ox.parse(content)
      end
    end
  end
end
