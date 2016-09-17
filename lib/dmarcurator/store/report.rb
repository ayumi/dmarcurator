# frozen_string_literal: true
# DMARC report. Contains many records.
module Dmarcurator
  class Store
    class Report
      attr_reader :db

      def self.create_table(db:)
        puts "Creating table: reports"
        db.create_table :reports do
          primary_key :id
          String :org_name
          String :email
          String :extra_contact_info
          String :report_id
          String :error
          DateTime :begin_at
          DateTime :end_at
          String :policy_domain
          String :policy_adkim
          String :policy_aspf
          String :policy_p
          String :policy_sp
          Integer :policy_pct

          index :report_id
        end
      end

      def self.import_parsed_report(db:, parsed_report:)
        create_table(db: db) if !db.table_exists?(:reports)
        if db[:reports].where(report_id: parsed_report.report_id).count > 0
          puts "Report exists; skipping"
          return
        end

        attributes = {}
        db[:reports].columns.each do |attribute|
          next if !parsed_report.respond_to?(attribute)
          attributes[attribute] = parsed_report.public_send(attribute)
        end
        db[:reports].insert(attributes)
      end
    end
  end
end
