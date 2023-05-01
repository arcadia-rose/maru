# Packages

`packages.yml` contains a record of known legacy packages in [nixpkgs](https://search.nixos.org/packages)'
**unstable** branch.  Usually, the names of packages in nixpkgs correspond directly to what you'd expect
(e.g. `vim` for vim, `ripgrep` for ripgrep) but sometimes there's a translation that needs to take place.
Maru provides a thin abstraction over nixpkgs' naming convention and also creates a distinction between
packages that are added to a development environment independantly and things like programming language
support, which might include several packages. These abstractions help guide developers toward the most
seamless configuration we can provide.

If a package you want isn't in `packages.yml`, feel free to open a pull request to support it. When a
package's alias and nixpkgs name are identical, the value `~` indicates they are the same. Otherwise,
the format is

```yaml
alias: nixpkgs-name
```
