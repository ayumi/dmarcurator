# frozen_string_literal: true
require "sequel"

module Dmarcurator
  # Import DMARC XML reports into DB
  class ImportReports
    attr_reader :db, :reports_path

    def initialize(db_uri:, reports_path:)
      @db = Sequel.connect(db_uri)
      @reports_path = reports_path
    end

    def run
      puts "Importing #{reports_path}"
      Dir.foreach(reports_path) do |path|
        next if path == '.' || path == '..' || File.extname(path) != ".xml"
        puts "  #{path}"
        parsed_report = ::Dmarcurator::Parser::Report.new(xml: "#{reports_path}/#{path}")
        ::Dmarcurator::Store::Report.import_parsed(db: db, parsed: parsed_report)
      end
      puts "Done importing :)"
    end
  end
end
