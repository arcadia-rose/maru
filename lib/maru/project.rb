# typed: strict

module Maru
  class Project
    extend T::Sig

    class << self
      extend T::Sig

      sig { returns(T.nilable(Project)) }
      def current
        at(Dir.pwd)
      rescue Errno::ENOENT
        raise RuntimeError, "You seem to have deleted the project while {{command:maru}} was running"
      end

      sig { params(dir: String).returns(T.nilable(Project)) }
      def at(dir)
        proj_dir = directory(dir)
        return nil if proj_dir.nil?

        new(proj_dir)
      end

      sig { params(dir: String).returns(T.nilable(String)) }
      def directory(dir)
        ancestors_of(dir).detect do |current|
          File.exist?(File.join(current, "maru.rb"))
        end
      end

      private

      sig { params(dir: String).returns(T::Enumerable[String]) }
      def ancestors_of(dir)
        enum_for(:ancestors_of_helper, dir)
      end

      sig do
        type_parameters(:T)
          .params(
            dir: String,
            block: T.proc.params(dir: String).returns(T.type_parameter(:T)))
          .void
      end
      def ancestors_of_helper(dir, &block)
        return if dir.nil?

        dir = File.realpath(dir)
        loop do
          block.call(dir)
          break if dir == '/'

          dir = File.dirname(dir)
        end
      end
    end

    sig { params(dir: String).void }
    def initialize(dir)
      @base = T.let(dir, String)
    end

    sig { returns(T.nilable(String)) }
    def maru_rb
      path = File.join(@base, "maru.rb")
      return nil unless File.exist?(path)

      path
    end
  end
end
