require 'spec_helper'

describe 'Default User' do
  describe user('root') do
    it { should exist }
    it { should have_uid 0 }
    it { should have_home_directory '/root' }
  end

  describe group('root') do
    it { should have_gid 0 }
  end
  describe user('vagrant') do
    it { should exist }
    it { should have_uid 1000 }
    it { should have_home_directory '/home/vagrant' }
  end

  describe group('vagrant') do
    it { should have_gid 1000 }
  end
end

describe 'Default Packages' do
  %w( ruby2.3 ruby2.3-dev git vim dkms virtualbox ).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end

path='/home/vagrant/.gem/ruby/2.3.0/bin/'
describe 'Serverspec Files' do
  %w( kitchen rake serverspec-init serverspec-runner ).each do |pkg|
    describe file(path+pkg) do
      it { should be_file }
      it { should be_executable }
      it { should be_owned_by 'vagrant' }
      it { should be_grouped_into 'vagrant' }
    end
  end
end

path='/home/vagrant/.gem/ruby/2.3.0/gems/'
describe 'kitchen.ci plugins' do
  %w(kitchen-vagrant*).each do |pkg|
    describe command('ls -d '+path+pkg) do
      its(:exit_status) { should eq 0 }
    end
  end
end
