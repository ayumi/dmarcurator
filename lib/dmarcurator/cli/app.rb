# frozen_string_literal: true
module Dmarcurator
  module Cli
    class App
      def self.main
        puts "Hello #{name}"
        puts "ARGV was: #{ARGV}"
      end
    end
  end
end
