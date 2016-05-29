require 'rest-client'
require_relative 'system_monitor'

class CpuMonitorJob

  REQUIRED_PARAMS = [:url, :id, :hostname]

  attr_reader :url, :id, :hostname

  def initialize(params = {})
    check params

    @url = params[:url]
    @id = params[:id]
    @hostname = params[:hostname]

    RestClient.log = params[:logger]
  end

  def perform
    RestClient.post url, cpu_monitor_report.to_json, content_type: :json, accept: :json
  end

  private

  def check(params)
    missing = REQUIRED_PARAMS - params.keys
    raise "Required params are missing: #{missing.inspect}" unless missing.empty?
  end

  def cpu_monitor_report
    { id: id, hostname: hostname, report: SystemMonitor.report }
  end
end
