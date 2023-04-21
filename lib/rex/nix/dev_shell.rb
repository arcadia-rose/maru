module Rex
  module Nix
    class DevShell
      def name; "default"; end
      def legacy_packages; []; end
      def inputs; []; end
      def shell; ""; end

      def to_nix(system)
        <<~NIX
          devShells.#{system}.#{name} = (pkgs: with pkgs; pkgs.mkShell {
            buildInputs = [ #{legacy_packages.join(" ") } ];
            inputsFrom = [ #{inputs.join(" ") } ];
            shellHook = ''
              #{shell}
            '';
          };)
        NIX
      end
    end
  end
end
