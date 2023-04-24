module Maru
  class Language < Maru::Nix::DevShell
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
