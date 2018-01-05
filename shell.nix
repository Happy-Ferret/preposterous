let 
  rien = import ./util/rien/rien.nix {
    packageName = "preposterous";
    packagePath = ./.;

    # Instead of using <nixpkgs>, use a lock-file to stick to
    # a particular `nixpkgs` commit.
    nixpkgsLock = ./nixpkgs.json;

    ghcVersion = "ghc822";

    overrides = rec {
      jailbreak = [ "cabal-helper" "ghc-mod" "liquidhaskell" ];
      skipHaddock = justStaticExecutables;
      skipTests = [ "ghc-mod" "hpack" ];
      justStaticExecutables = [ 
        "brittany" 
        "hpack"
        "ghcid"
        "hpack"
      ];
    };
  };

in
  rien.shell {
    # Generate Hoogle documentation?
    wantHoogle = false;

    # Haskell dependencies
    deps = hsPkgs: with hsPkgs; [
      brittany
      ghc-mod
      cabal-helper
      hpack

      text
      bound
      prettyprinter
      lens

      # containers
      # logict
      # QuickCheck

      # hpack
      # ghcid
      # hlint
      # adjunctions
      # exceptions
      # hashable
      # hspec
      # lens
      # mtl
      # prettyprinter
      # prettyprinter-ansi-terminal
      # profunctors
      # safe
      # text
      # uniplate
      # unordered-containers
    ];

    # Optionally, also add sets of related packages that are
    # commonly used together.
    depSets = hsPkgs: with (rien.package-sets hsPkgs); [
      development-servers
    ];

    # Native dependencies
    nativeDeps = pkgs: with pkgs; [ 
      # z3 
    ];
  }
