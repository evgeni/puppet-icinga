require 'spec_helper'
describe 'icinga::service' do
  describe 'on Debian-based systems' do
    let (:facts) { {
      :osfamily => 'Debian',
    } }
    it {
      should contain_class('icinga::service')
      should contain_service('icinga')
    }
  end
end

