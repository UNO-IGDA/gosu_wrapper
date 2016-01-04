require 'faker'
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

    describe '.start' do
      subject(:start) { described_class.start }

      it 'calls instance.start' do
        expect(documentation_server).to receive(:start)

        start
      end
    end

    describe '#pid' do
      subject(:pid) { documentation_server.pid }

      it('is a Fixnum') { is_expected.to be_a Fixnum }
    end

    describe '#start' do
      subject(:start) { documentation_server.start }
      let(:pid) { Faker::Number.number(2) }

      it 'spawns a detached "yard server --reload" process' do
        expect(Process).to receive(:spawn)
          .with('yard server --reload').and_return(pid).ordered
        expect(Process).to receive(:detach).with(pid).ordered

        start
      end

      it 'assigns #pid the process id' do
        allow(Process).to receive(:spawn)
          .with('yard server --reload').and_return(pid).ordered
        allow(Process).to receive(:detach).with(pid).ordered

        expect { start }.to change { documentation_server.pid }.to pid
      end
    end
  end
end
