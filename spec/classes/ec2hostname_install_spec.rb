require 'spec_helper'

describe 'ec2hostname::install', :type => :class do
  let(:params) { {
    :aws_key     => 'abc',
    :aws_secret  => 'def',
    :hostname    => 'myhost',
    :domain      => 'mydomain.com',
    :ttl         => 60,
    :type        => 'CNAME',
    :target      => 'local-hostname',
    :zone        => '123',
  } }

  context 'aws-sdk gem' do
    context 'not install by default' do
      it { should_not contain_package('aws-sdk') }
    end

    context 'install with install_gem' do
      let(:pre_condition) { [ "class ec2hostname { $install_gem = true }", "include ec2hostname" ] }
      it { should contain_package('aws-sdk').with(:provider => 'gem') }
    end
  end

  context 'install the init script' do
    it { should contain_file('/etc/init.d/ec2hostname') }
  end
end
