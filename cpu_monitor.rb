#encoding: UTF-8
require_relative 'lib/cpu_monitor_job'
require 'yaml'
require 'logger'

module CpuMonitor

  def self.execute
    log.info('CPU Monitor Client Started!')
    log.info("Config: #{config.inspect}")

    job = CpuMonitorJob.new(url: config['url'], id: config['id'], hostname: config['hostname'], logger: log)

    loop do
      begin
        log.info(job.perform)
      rescue Exception => msg
        log.error msg
      end
      sleep(5)
    end
  end

  private

  def self.config_file
    File.join(File.dirname(__FILE__), 'config.yml')
  end

  def self.config
    @config ||= YAML.load_file(config_file)
  end

  def self.log_file
    File.join(File.dirname(__FILE__), config['log_file'])
  end

  def self.log
    @log ||= Logger.new(log_file, 'daily', 10)
  end

end

CpuMonitor.execute