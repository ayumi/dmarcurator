# frozen_string_literal: true
module Dmarcurator
  module Cli
    class App
      require "pry"

      attr_reader :db_uri, :reports_path

      def self.main
        params = parse_options(ARGV)
        new(params).run
      end

      def self.parse_options(options)
        params = {}

        opt_parser = OptionParser.new do |parser|
          parser.banner = "dmarcurator parses DMARC reports and stores them into an SQLite3 DB.\nIt can also serve a basic web UI for viewing reports (-ui=true).\nUsage: dmarcurator [options]"

          parser.on("-db", "--db-sqlite=SQLITE_DB", "[Required] Path to sqlite3 DB. (e.g. ./tmp/reports.sqlite)") do |value|
            params[:db_path] = value
          end

          parser.on("-rp", "--reports-path=REPORTS_PATH", "Path to directory containing DMARC reports. (e.g. ./tmp/reports/)") do |value|
            params[:reports_path] = value
          end

          parser.on("-h", "--help", "Halp pls") do
            puts parser
            exit 0
          end

          parser.on("-v", "--version", "Print version") do
            puts ::Dmarcurator::VERSION
            exit 0
          end

          if options.empty?
            puts parser
            exit 1
          end
        end

        opt_parser.parse!(options)
        if !params[:reports_path]
          puts "Dmarcurator can import DMARC reports into an sqlite3 database -> Set --db and --reports-path)"
          exit 0
        end

        params
      end

      def initialize(db_path:, reports_path: nil)
        @db_uri = "sqlite://#{File.expand_path(db_path)}"
        @reports_path = reports_path
      end

      def run
        if reports_path
          ::Dmarcurator::ImportReports.new(db_uri: db_uri, reports_path: reports_path).run
        end
      end
    end
  end
end
