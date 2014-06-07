require 'spec_helper'
describe 'icinga::nrpe' do
  describe 'on Debian-based systems' do
    let (:facts) { {
      :osfamily => 'Debian',
    } }
    it {
      should contain_class('icinga::nrpe')
      should contain_class('icinga::nrpe::package')
      should contain_class('icinga::nrpe::config')
      should contain_class('icinga::nrpe::service')
      should contain_package('nagios-nrpe-server')
      should contain_service('nagios-nrpe-server')
    }
  end
  describe 'on RedHat-based systems' do
    let (:facts) { {
      :osfamily => 'RedHat',
    } }
    it {
      should contain_class('icinga::nrpe')
      should contain_class('icinga::nrpe::package')
      should contain_class('icinga::nrpe::config')
      should contain_class('icinga::nrpe::service')
      should contain_package('nrpe')
      should contain_service('nrpe')
    }
  end
end

