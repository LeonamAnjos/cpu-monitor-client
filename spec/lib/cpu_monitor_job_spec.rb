require 'spec_helper'
require 'cpu_monitor_job'
describe CpuMonitorJob do
  subject(:job) { CpuMonitorJob.new(params) }

  context 'with invalid params' do
    let(:params) { Hash.new }
    let(:message_error) { "Required params are missing: #{[:url, :id, :hostname]}" }

    it 'should raise error' do
      expect { job }.to raise_error(RuntimeError, message_error)
    end
  end

  context 'with valid params' do
    let(:report) { { cpu: 2.5, disk: 4.9, process: [%w{/proc1 2.3}, %w{/proc2 3.5}]} }
    let(:params) do
      { id: '123456',
        hostname: 'my-host',
        url: 'http://example.com/cpu',
        report: report}
    end
    let(:payload) { { id: params[:id], hostname: params[:hostname], report: report } }

    before do
      expect(SystemMonitor).to receive(:report).once.and_return report
      expect(RestClient).to receive(:post).with(params[:url], payload.to_json, content_type: :json, accept: :json)
    end

    describe '#perform' do
      its(:perform) { is_expected.to be_eql ''}
    end
  end


end