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
      should contain_service('nagios-nrpe-server')
    }
  end
end

