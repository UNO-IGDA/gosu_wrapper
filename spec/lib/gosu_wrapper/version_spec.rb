require 'spec_helper'

module GosuWrapper
  RSpec.describe '::VERSION' do
    subject(:version) { GosuWrapper::VERSION }

    it('is "0.1.0"') { is_expected.to eq '0.1.0' }
  end
end
