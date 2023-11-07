Title: A Nix Flake Template
Author: Paul-Nicolas Madelaine
Date: 2023-11-07
Category: Blog
Summary: I wrote a Flake template

I learned to use Nix when flakes were already ubiquitous, and I realized
recently that by learning Nix through flakes I adopted some bad coding habits. I
don't think I am the only one that tends to overload their `flake.nix` (the
flake of [Nix](http://github.com/nixos/nix/blob/master/flake.nix) is over 700
lines long at the time of writing). Paradoxically, this makes flake expressions
less discoverable, or at least less flexible. For instance, how do you override
the package expression defined in a `flake.nix` to try and build it for a system
that is not explicitly exposed by this flake? In many cases, you can't! Just
fork the repository and patch the Nix code!

A friend recently told me about [Niv](https://github.com/nmattia/niv), and I
really liked the way I naturally set up my projects when trying it out, namely
in a more modular fashion than before. Even if I decided to stick with flakes, I will
be trying to write them in a more modular way going forward.

If you are interested, I wrote a
[template](https://github.com/pnmadelaine/flake) that I will be using for medium
to large projects in the future (it may be a bit ridiculous for smaller flakes).
For a non-trivial example, you can take a look at
[Typhon](https://github.com/typhon-ci/typhon) (more on that soon, hopefully!).
