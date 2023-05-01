# typed: strict

require 'yaml'

module Maru
  class Packages
    extend T::Sig
    include Maru::Nix::DevShell

    class UnknownPackageError < StandardError; end

    @@packages = T.let(nil, T.nilable(T::Hash[String, String]))

    class << self
      extend T::Sig

      sig { returns(T::Hash[String, String]) }
      def packages_yml
        @@packages ||= File.open(File.join(Maru::ROOT, "misc", "packages.yml")) do |f|
          YAML.load(f.read).each_with_object({}) do |(pkg_alias, pkg_name), mapping|
            mapping[pkg_alias] = pkg_name || pkg_alias
          end
        end
      end
    end

    sig { params(names: T::Array[String]).void }
    def initialize(names)
      @package_keys = names
    end

    sig { override.returns(T::Array[String]) }
    def legacy_packages
      @package_keys.map { |key| Packages.packages_yml[key] }.compact
    end

    sig { returns(T::Array[Maru::Nix::Output]) }
    def outputs
      missing = @package_keys.reject { |key| Packages.packages_yml.key?(key) }
      unknown_package_error(missing) unless missing.empty?

      [ self ]
    end

    private

    sig { params(pkgs: T::Array[String]).void }
    def unknown_package_error(pkgs)
      raise(UnknownPackageError, ::CLI::UI.fmt(<<~MSG))
        Maru doesn't know about the following package(s): {{bold:#{pkgs.join(', ')}}}.

        Please submit a pull request adding them to {{bold:misc/packages.yml}} so that Maru can support you!
      MSG
    end
  end
end
