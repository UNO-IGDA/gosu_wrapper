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

    describe '.running?' do
      subject(:running?) { described_class.running? }

      it 'calls instance.running?' do
        expect(documentation_server).to receive(:running?)

        running?
      end
    end

    describe '.start' do
      subject(:start) { described_class.start }

      it 'calls instance.start' do
        expect(documentation_server).to receive(:start)

        start
      end
    end

    describe '#pid' do
      subject(:pid) { documentation_server.pid }

      context 'when the server is running' do
        let(:new_pid) { Faker::Number.number(2) }

        before :example do
          allow(Process).to receive(:spawn).and_return(new_pid)
          allow(Process).to receive(:detach).with(new_pid)
          documentation_server.start
        end

        it 'is the id of the running server process' do
          is_expected.to eq new_pid
        end
      end

      context 'when the server is not running' do
        before :example do
          allow(Process).to receive(:kill)
          documentation_server.stop
        end

        it('is nil') { is_expected.to be_nil }
      end
    end

    describe '#running?' do
      subject(:running?) { documentation_server.running? }

      context 'when #pid is a Fixnum' do
        before :example do
          allow(documentation_server).to receive(:pid)
            .and_return Faker::Number.number(2)
        end

        context 'when a process with a PID of #pid exists' do
          before :example do
            allow(Process).to receive(:kill)
              .with(0, documentation_server.pid)
          end

          it('is true') { is_expected.to be true }
        end

        context 'when a process with a PID of #pid does not exist' do
          before :example do
            allow(Process).to receive(:kill)
              .with(0, documentation_server.pid)
              .and_raise(Errno::ESRCH, 'No such process')
          end

          it('is false') { is_expected.to be false }
        end
      end

      context 'when #pid is nil' do
        before :example do
          allow(documentation_server).to receive(:pid).and_return nil
        end

        it('is false') { is_expected.to be false }
      end
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

    describe '#stop' do
      subject(:stop) { documentation_server.stop }

      context 'when the server is not running' do
        before :example do
          allow(documentation_server).to receive(:running?)
            .and_return false
        end

        it 'does not attempt to kill a process' do
          expect(Process).not_to receive(:kill)

          stop
        end

        it 'does not attempt to delete #pid' do
          expect { stop }.not_to change { documentation_server.pid }
        end
      end

      context 'when the server is running' do
        let(:new_pid) { Faker::Number.number(2) }

        before :example do
          allow(Process).to receive(:spawn).and_return(new_pid)
          allow(Process).to receive(:detach).with(new_pid)
          documentation_server.start
          allow(documentation_server).to receive(:running?).and_return true
        end

        it 'kills the server process with "INT" signal' do
          expect(Process).to receive(:kill)
            .with('INT', documentation_server.pid)

          stop
        end

        it 'deletes #pid' do
          allow(Process).to receive(:kill)

          expect { stop }.to change { documentation_server.pid }.to nil
        end
      end
    end
  end
end
