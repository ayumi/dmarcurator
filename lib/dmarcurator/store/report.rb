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
          String :dmarc_report_id
          String :error
          DateTime :begin_at
          DateTime :end_at
          String :policy_domain
          String :policy_adkim
          String :policy_aspf
          String :policy_p
          String :policy_sp
          Integer :policy_pct

          index :dmarc_report_id
        end
      end

      def self.import_parsed(db:, parsed:)
        create_table(db: db) if !db.table_exists?(:reports)
        if db[:reports].where(dmarc_report_id: parsed.dmarc_report_id).count > 0
          puts "Report exists; skipping"
          return
        end

        attributes = {}
        db[:reports].columns.each do |attribute|
          next if !parsed.respond_to?(attribute)
          attributes[attribute] = parsed.public_send(attribute)
        end
        result = db[:reports].insert(attributes)
        imported_report_id = db[:reports].select(:id).order('id ASC').limit(1).first[:id]

        parsed.records.each do |parsed_record|
          Record.import_parsed(db: db, parsed: parsed_record, report_id: imported_report_id)
        end
        puts "Report++"
      end
    end
  end
end
