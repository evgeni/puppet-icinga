require 'spec_helper'
describe 'icinga' do

  context 'with defaults for all parameters' do
    it { should contain_class('icinga') }
  end
end
