Title: Nix registry
Author: Paul-Nicolas Madelaine
Date: 2022-06-09
Category: Blog
Summary: A quick note about a small trick I implemented in my NixOS configurations.

*A quick note about a small trick I implemented in my NixOS configurations.*

I started using [flakes](https://nixos.wiki/wiki/Flakes) a few months ago, and
quickly began using them daily. Notably, I moved the NixOS configurations for
all my machines in a single flake. But there has been a caveat in my workflow:
using flakes for almost every project I compile made me end up with lots of
different versions of Nixpkgs lying around. It became very annoying when
compiling LaTeX documents: two LaTeX projects created a few hours apart could be
using different versions of Nixpkgs, and thus different versions of TexLive.
Downloading a few gigabytes every time I set up a LaTeX project was not very
optimal. I began copying lock files between projects, but it only made me more
frustrated.

Nix uses a
[registry](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-registry.html)
to resolve flake URIs. For instance, it resolves the special flake URI "nixpkgs"
to "github:nixpkgs/nixos-unstable". We can configure the registry system-wide to
map "nixpkgs" to a specific revision of the repository. Using the "rev"
attribute of a flake input, we can even point it to the same revision as the one
used by our flake-defined configuration.

The module to configure the Nix registry looks like this:

```
{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, }: {

    nixosModule = {
      nix.registry.nixpkgs = {
        from = {
          type = "indirect";
          id = "nixpkgs";
        };
        to = {
          type = "github";
          owner = "nixos";
          repo = "nixpkgs";
          inherit (nixpkgs) rev;
        };
      };
    };

  };

}
```

The Nix registry can also be configured at the user level, and this module can
be used as a home-manager module.
