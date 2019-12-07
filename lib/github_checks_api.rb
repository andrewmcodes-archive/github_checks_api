require 'net/http'
require 'json'
require 'time'
require "github_checks_api/version"
require "github_checks_api/run"
require "github_checks_api/client"
require "github_checks_api/report"

module GithubChecksApi
  class Error < StandardError; end
end
