require 'usagewatch'

class SystemMonitor

  def cpu_usage
    system.uw_cpuused
  end

  def disk_usage
    system.uw_diskused_perc
  end

  def process_running
    system.uw_cputop
  end

  private

  def system
    @system ||= Usagewatch
  end

end