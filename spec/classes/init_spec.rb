require 'spec_helper'
describe 'file_bundles' do

  context 'with defaults for all parameters' do
    it { should contain_class('file_bundles') }
  end
end
