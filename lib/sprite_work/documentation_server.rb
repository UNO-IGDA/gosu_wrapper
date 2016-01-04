require 'singleton'

module SpriteWork
  # A small server application to host live documentation.
  class DocumentationServer
    include Singleton

    attr_accessor :pid

    def self.running?
      instance.running?
    end

    def self.start
      instance.start
    end

    def running?
      return false unless pid
      Process.kill(0, pid)
      true
    rescue Errno::ESRCH
      false
    end

    def start
      @pid = Process.spawn('yard server --reload')
      Process.detach(pid)
    end

    def stop
      return unless running?
      Process.kill('INT', pid)
      @pid = nil
    end
  end
end
