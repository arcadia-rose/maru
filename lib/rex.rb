module Rex
  autoload :Language, "rex/language"

  module Nix
    autoload :DevShell, "rex/nix/dev_shell"
    autoload :Flake,    "rex/nix/flake"
    autoload :Input,    "rex/nix/input"
  end

  module Languages
    autoload :Ruby, "rex/languages/ruby"
  end
end
