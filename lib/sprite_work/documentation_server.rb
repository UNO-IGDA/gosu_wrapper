require 'singleton'

module SpriteWork
  # A small server application to host live documentation.
  class DocumentationServer
    include Singleton

    def self.start
      instance.start
    end

    def start
    end
  end
end
