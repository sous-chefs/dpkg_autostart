# frozen_string_literal: true

control 'dpkg-autostart-policy-01' do
  impact 1.0
  title 'policy-rc.d is installed with the configured services'

  describe file('/usr/sbin/policy-rc.d') do
    it { should exist }
    it { should be_executable }
    its('content') { should match(/DISABLE_ACTIONS=\( restart start \)/) }
    its('content') { should match(/DISABLED_SERVICES=\( apache2 mysql-server \)/) }
  end
end

control 'dpkg-autostart-policy-02' do
  impact 1.0
  title 'policy-rc.d denies configured starts and allows other operations'

  describe command('/usr/sbin/policy-rc.d mysql-server start') do
    its('exit_status') { should cmp 101 }
  end

  describe command('/usr/sbin/policy-rc.d apache2 restart') do
    its('exit_status') { should cmp 101 }
  end

  describe command('/usr/sbin/policy-rc.d mysql-server status') do
    its('exit_status') { should cmp 104 }
  end

  describe command('/usr/sbin/policy-rc.d redis-server start') do
    its('exit_status') { should cmp 104 }
  end
end
