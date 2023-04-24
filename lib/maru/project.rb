module Maru
  class Project
    class << self
      def current
        at(Dir.pwd)
      rescue Errno::ENOENT
        raise RuntimeError, "You seem to have deleted the project while {{command:maru}} was running"
      end

      def at(dir)
        proj_dir = directory(dir)
        return nil unless proj_dir

        new(proj_dir)
      end

      def directory(dir)
        ancestors_of(dir).detect do |current|
          File.exist?(File.join(current, "maru.rb"))
        end
      end

      private

      def ancestors_of(dir)
        enum_for(:ancestors_of_helper, dir)
      end

      def ancestors_of_helper(dir, &block)
        return if dir.nil?

        dir = File.realpath(dir)
        loop do
          yield(dir)
          break if dir == '/'

          dir = File.dirname(dir)
        end
      end
    end

    def initialize(dir)
      @base = dir
    end

    def maru_rb
      path = File.join(@base, "maru.rb")
      return nil unless File.exist?(path)

      path
    end
  end
end
