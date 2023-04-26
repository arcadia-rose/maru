module Maru
  module Nix
    module Services
      class Builtin < Service
        def config
          {}
        end

        def to_nix
          <<~NIX
            #{name} = {
              #{config.map do |key, value|
              "#{key} = #{Maru::Nix::Language.format(value)};"
              end.join("\n")}
            };
          NIX
        end
      end
    end
  end
end
