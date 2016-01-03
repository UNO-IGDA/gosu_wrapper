require 'spec_helper'

module SpriteWork
  RSpec.describe '::VERSION' do
    subject(:version) { SpriteWork::VERSION }

    it('is "0.1.0"') { is_expected.to eq '0.1.0' }
  end
end
