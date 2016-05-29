#encoding: utf-8
require 'spec_helper'
require 'system_monitor'

describe SystemMonitor do
  subject(:system) { SystemMonitor }
  let(:shell) { SystemShell }

  describe '#report' do
    before do
      expect(shell).to receive(:execute).with(kind_of String).and_return 'cpu  4520736 34092 743549 53679598 1168075 0 4510 0 0 0'
      expect(shell).to receive(:execute).with(kind_of String).and_return("total          967952095 59351458 860122893   7% -\n")
      expect(shell).to receive(:execute).with(kind_of String).and_return("/proc1 5.3\n/proc2 3.5\n")
    end

    its(:report) { is_expected.to be_eql({cpu: 8.98, disk: 6.9, process: [ %w{/proc1 5.3}, %w{/proc2 3.5} ]})}
  end

end

