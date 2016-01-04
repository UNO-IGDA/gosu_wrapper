require 'spec_helper'
require 'sprite_work/documentation_server'

module SpriteWork
  tags = {
    lib: SpriteWork::DocumentationServer,
    type: :lib
  }

  RSpec.describe DocumentationServer, tags do
    subject(:documentation_server) { described_class.instance }

    it('is a Singleton') { is_expected.to be_a Singleton }
  end
end
