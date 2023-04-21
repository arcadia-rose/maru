module Rex
  class Language < Rex::Nix::DevShell
    def packages; end
    def setup; ''; end

    def legacy_packages
      packages
    end

    def shell
      setup
    end
  end
end
