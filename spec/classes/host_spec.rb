require 'spec_helper'
describe 'icinga::host' do
  describe 'on Debian-based systems' do
    let (:facts) { {
      :osfamily => 'Debian',
    } }
    it {
      should contain_class('icinga::host')
      should contain_class('icinga::nrpe')
    }
  end
end


