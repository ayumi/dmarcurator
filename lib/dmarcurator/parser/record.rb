# frozen_string_literal: true
module Dmarcurator
  module Parser
    # Parsed XML of a record
    class Record < Base
      def source_ip
        doc.locate("row/source_ip")[0].text
      end

      def count
        doc.locate("row/count")[0].text.to_i
      end

      def disposition
        doc.locate("row/policy_evaluated/disposition")[0].text
      end

      def policy_result_dkim
        doc.locate("row/policy_evaluated/dkim")[0].text
      end

      def policy_result_spf
        doc.locate("row/policy_evaluated/spf")[0].text
      end

      def envelope_to
        doc.locate("identifiers/envelope_to")[0]&.text
      end

      def header_from
        doc.locate("identifiers/header_from")[0].text
      end

      def auth_dkim_domain
        doc.locate("auth_results/dkim/domain")[0]&.text
      end

      def auth_dkim_result
        doc.locate("auth_results/dkim/result")[0]&.text
      end

      def auth_dkim_selector
        doc.locate("auth_results/dkim/selector")[0]&.text
      end

      def auth_spf_domain
        doc.locate("auth_results/spf/domain")[0].text
      end

      def auth_spf_result
        doc.locate("auth_results/spf/result")[0].text
      end
    end
  end
end
