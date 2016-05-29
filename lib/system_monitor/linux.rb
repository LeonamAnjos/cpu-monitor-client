#encoding: UTF-8
require_relative 'system_shell'

module SystemMonitor

  def self.cpu_usage
    proc_stat = get_proc_stat

    proc_total = proc_stat.reduce(:+)
    proc_usage = proc_total - proc_idle(proc_stat)

    cpu_usage_percent(proc_total, proc_usage)
  end

  def self.disk_usage
    df = shell.execute 'df --total'

    total_df = total_df_values(df)

    used = used_disk(total_df)
    available = available_disk(total_df)

    disk_usage_percent(available, used)
  end

  def self.process_running
    ps = shell.execute "ps aux | awk '{print $11, $3}' | sort -k2nr  | head -n 15"

    process = []
    ps.each_line { |line| process << line.chomp.split(' ') }
    process
  end

  private

  def self.shell
    SystemShell
  end

  def self.get_proc_stat
    cmd_result = shell.execute "cat /proc/stat | grep '^cpu '"
    cmd_result.chomp.split(' ').slice(1..4).map { |i| i.to_i }
  end

  def self.proc_idle(proc_stat)
    proc_stat.last
  end

  def self.cpu_usage_percent(proc_total, proc_usage)
    cpu_usage = proc_total != 0 ? proc_usage.fdiv(proc_total) : 0
    (cpu_usage * 100).round(2)
  end

  def self.total_df_values(df)
    df.slice(df.index('total'), df.size).split(' ')
  end

  def self.used_disk(total_df)
    total_df[2].to_i
  end

  def self.available_disk(total_df)
    total_df[3].to_i
  end

  def self.disk_usage_percent(available, used)
    return 0 if available == 0
    (used.fdiv(available) * 100).round(2)
  end

end