require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'iptables class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'iptables': }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe service($servicename) do
      it { should be_enabled }
      it { is_expected.to be_running }
    end

    describe file($ruleset) do
      it { should be_file }
      its(:content) { should match ':INPUT ACCEPT [0:0]' }
      its(:content) { should match ':FORWARD ACCEPT [0:0]' }
      its(:content) { should match ':OUTPUT ACCEPT [0:0]' }
    end

  end
end
