# frozen_string_literal: true
require "sequel"

module Dmarcurator
  class Store
    # DMARC report. Contains many records.
    class Record < Sequel::Model
      attr_reader :db

      def self.create_table
        db.create_table :records do
          primary_key :id
          foreign_key(:report_id, :report, key: :id)
          String :source_ip
          Integer :count
          String :disposition
          String :result_dkim
          String :result_spf
          String :envelope_to
          String :header_from
          Text :source
        end
      end

      def initialize(db_uri)
        @db = Sequel.connect(db_uri)
      end
    end
  end
end
