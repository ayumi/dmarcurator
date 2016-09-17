# frozen_string_literal: true
require "sequel"

module Dmarcurator
  class Store
    # DMARC report. Contains many records.
    class Record
      attr_reader :db

      def self.create_table(db:)
        db.create_table :records do
          primary_key :id
          foreign_key(:report_id, :reports, key: :id)
          String :source_ip
          Integer :count
          String :disposition
          String :policy_result_dkim
          String :policy_result_spf
          String :envelope_to
          String :header_from
          String :auth_dkim_domain
          String :auth_dkim_result
          String :auth_dkim_selector
          String :auth_spf_domain
          String :auth_spf_result
        end
      end

      def self.import_parsed(db:, parsed:, report_id:)
        create_table(db: db) if !db.table_exists?(:records)

        attributes = { report_id: report_id }
        db[:records].columns.each do |attribute|
          next if !parsed.respond_to?(attribute)
          attributes[attribute] = parsed.public_send(attribute)
        end
        result = db[:records].insert(attributes)
        STDOUT << "."
      end
    end
  end
end
