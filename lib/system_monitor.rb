#encoding: UTF-8
os = RUBY_PLATFORM

if os.include? 'linux'
  require_relative 'system_monitor/linux'
else
  raise 'Unsupported OS! Only Linux Operating System is supported.'
end

module SystemMonitor
  def self.report
    {cpu: cpu_usage, disk: disk_usage, process: process_running}
  end
end
