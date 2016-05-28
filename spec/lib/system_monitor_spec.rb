require 'spec_helper'
require 'system_monitor'
describe SystemMonitor do
  subject(:system) { SystemMonitor.new }

  describe '#cpu_usage' do
    let(:cpu_used_percent) { 5.1 }
    before { expect(Usagewatch).to receive(:uw_cpuused).once.and_return cpu_used_percent }

    its(:cpu_usage) { is_expected.to be_eql cpu_used_percent }
  end

  describe '#disk_usage' do
    let(:disk_used_percent) { 32.5 }
    before { expect(Usagewatch).to receive(:uw_diskused_perc).once.and_return disk_used_percent }

    its(:disk_usage) { is_expected.to be_eql disk_used_percent }
  end

  describe '#process_running' do
    let(:list_of_process) do
      [['/usr/lib/jvm/java-8-oracle/bin/java', '8.7'],
       ['/usr/bin/gnome-shell', '3.5'],
       ['/usr/lib/xorg/Xorg', '3.1']]
    end
    before { expect(Usagewatch).to receive(:uw_cputop).once.and_return(list_of_process) }

    its(:process_running) { is_expected.to be_eql (list_of_process) }
  end

end