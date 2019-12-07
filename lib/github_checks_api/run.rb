module GithubChecksApi
  class Run
    attr_accessor :report, :github_data, :check_name
    def initialize(report: nil, github_data: nil, check_name: nil)
      @report = Report.new(report)
      @github_data = github_data
      @check_name = check_name
      @client = Client.new(github_data[:token], user_agent: 'github_checks_api')
    end

    def perform
      id = create_check['id']
      update_check(id)
    end

    private

    def create_check
      client.post(endpoint_url, create_check_payload)
    end

    def update_check(id)
      client.patch("#{endpoint_url}/#{id}", update_check_payload)
    end

    def endpoint_url
      "/repos/#{github_data[:owner]}/#{github_data[:repo]}/check-runs"
    end

    def base_payload(status)
      {
        name: check_name,
        head_sha: github_data[:sha],
        status: status,
        started_at: Time.now.iso8601
      }
    end

    def create_check_payload
      base_payload('in_progress')
    end

    def update_check_payload
      base_payload('completed').merge!(
        conclusion: conclusion,
        output: {
          title: check_name,
          summary: summary,
          annotations: annotations
        }
      )
    end
  end
end
