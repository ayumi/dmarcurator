# frozen_string_literal: true
module Dmarcurator
  module Parser
    # Parsed XML of a report
    class Report < Base
      def org_name
        doc.locate("feedback/report_metadata/org_name")[0].text
      end

      def email
        doc.locate("feedback/report_metadata/email")[0].text
      end

      def extra_contact_info
        doc.locate("feedback/report_metadata/extra_contact_info")[0]&.text
      end

      def report_id
        doc.locate("feedback/report_metadata/report_id")[0].text
      end

      def error
        doc.locate("feedback/report_metadata/error")[0]&.text
      end

      def begin_at
        Time.at(doc.locate("feedback/report_metadata/date_range/begin")[0].text.to_i)
      end

      def end_at
        Time.at(doc.locate("feedback/report_metadata/date_range/end")[0].text.to_i)
      end

      def policy_domain
        doc.locate("feedback/policy_published/domain")[0].text
      end

      def policy_adkim
        doc.locate("feedback/policy_published/adkim")[0].text
      end

      def policy_aspf
        doc.locate("feedback/policy_published/aspf")[0].text
      end

      def policy_p
        doc.locate("feedback/policy_published/p")[0].text
      end

      def policy_sp
        doc.locate("feedback/policy_published/sp")[0]&.text
      end

      def policy_pct
        doc.locate("feedback/policy_published/pct")[0].text.to_i
      end

      def records
        #TODO
      end
    end
  end
end
