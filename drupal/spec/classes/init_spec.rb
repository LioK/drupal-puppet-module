require 'spec_helper'
describe 'drupal' do
  context 'with default values for all parameters' do
    it { should contain_class('drupal') }
  end
end
