lib = File.expand_path("../lib", __FILE__)
puts lib
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'env'

flake = Rex::Nix::Flake.new(
  description: "A first ever example!",
  outputs: Rex::Env.languages,
)

puts flake.to_nix("aarch64-darwin")
