require 'spec_helper'
describe 'icinga' do
  describe 'on Debian-based systems' do
    let (:facts) { {
      :osfamily => 'Debian',
    } }
    it {
      should contain_class('icinga')

      should contain_class('icinga::service')
      should contain_service('icinga')

      should contain_class('icinga::package')
      should contain_package('icinga')
      should contain_package('nagios-nrpe-plugin')

      should contain_file('/etc/icinga/objects/puppet/')
    }
  end
  describe 'on RedHat-based systems' do
    let (:facts) { {
      :osfamily => 'RedHat',
    } }
    it {
      should contain_class('icinga')

      should contain_class('icinga::service')
      should contain_service('icinga')

      should contain_class('icinga::package')
      should contain_package('icinga')
      should contain_package('nagios-plugins-nrpe')

      should contain_file('/etc/icinga/objects/puppet/')
    }
  end
  describe 'on other systems' do
    it {
      expect {
        should compile
      }.to raise_error(Puppet::Error, /This module only supports Debian-based systems/)
    }
  end
end
