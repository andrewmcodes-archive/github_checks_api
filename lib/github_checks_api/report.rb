module GithubChecksApi
  class Report
    attr_accessor :report
    def initialize(report)
      @report = report
    end

    def annotations
      return annotations if report.respond_to?(annotations)
      report.dig(:annotations)
    end

    def summary
      return summary if report.respond_to?(summary)
      report.dig(:summary)
    end

    def conclusion
      return summary if report.respond_to?(summary)
      report.dig(:summary)
    end
  end
end
