#encoding: utf-8
require 'spec_helper'
require 'system_monitor/linux'

describe SystemMonitor do
  subject(:system) { SystemMonitor }
  let(:shell) { SystemShell }

  describe '#cpu_usage' do
    before { expect(shell).to receive(:execute).with("cat /proc/stat | grep '^cpu '").and_return 'cpu  4520736 34092 743549 53679598 1168075 0 4510 0 0 0' }

    its(:cpu_usage) { is_expected.to be_eql 8.98 }
  end

  describe '#disk_usage' do
    before do
      expect(shell).to receive(:execute).with('df --total').and_return(
        "Filesystem     1K-blocks     Used Available Use% Mounted on\n"\
        "udev             4004656        0   4004656   0% /dev\n"\
        "tmpfs             804820    17988    786832   3% /run\n"\
        "/dev/sda2       19091584  7502192  10596524  42% /\n"\
        "tmpfs            4024096   374432   3649664  10% /dev/shm\n"\
        "tmpfs               5120        4      5116   1% /run/lock\n"\
        "tmpfs            4024096        0   4024096   0% /sys/fs/cgroup\n"\
        "/dev/sda1          47371     3610     43761   8% /boot/efi\n"\
        "/dev/sda4      934340712 51453172 835402664   6% /home\n"\
        "tmpfs             804820       12    804808   1% /run/user/120\n"\
        "tmpfs             804820       48    804772   1% /run/user/1000\n"\
        "total          967952095 59351458 860122893   7% -\n")
    end

    its(:disk_usage) { is_expected.to be_eql 6.9 }
  end

  describe '#process_running' do
    before do
      expect(shell).to receive(:execute).with("ps aux | awk '{print $11, $3}' | sort -k2nr  | head -n 15").and_return(
          "/usr/lib/jvm/java-8-oracle/bin/java 5.3\n"\
          "/opt/google/chrome/chrome 3.5\n/usr/bin/gnome-shell 2.8\n"\
          "/usr/lib/xorg/Xorg 2.7\n"\
          "/opt/google/chrome/chrome 1.6\n"\
          "/opt/google/chrome/chrome 1.4\n"\
          "/opt/google/chrome/chrome 1.2\n"\
          "/opt/google/chrome/chrome 0.5\n"\
          "/usr/share/atom/atom 0.5\n")
    end

    its(:process_running) do
      expected = [
          %w{/usr/lib/jvm/java-8-oracle/bin/java 5.3},
          %w{/opt/google/chrome/chrome 3.5},
          %w{/usr/bin/gnome-shell 2.8},
          %w{/usr/lib/xorg/Xorg 2.7},
          %w{/opt/google/chrome/chrome 1.6},
          %w{/opt/google/chrome/chrome 1.4},
          %w{/opt/google/chrome/chrome 1.2},
          %w{/opt/google/chrome/chrome 0.5},
          %w{/usr/share/atom/atom 0.5}
      ]

      is_expected.to be_eql expected
    end

  end



end