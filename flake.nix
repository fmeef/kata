{
  description = "Flutter with required native libraries";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:fmeef/nixpkgs/botan3_android";
    flake-utils.url = "github:numtide/flake-utils";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      nix-vscode-extensions,
      nixpkgs-master,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };
        crosspkgs = import nixpkgs {
          inherit system;
          crossSystem = {
            config = "x86_64-darwin";
          };
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        sdkargs = {
          useAndroidPrebuilt = true;
          androidSdkVersion = "28";
          androidNdkVersion = "27";
          useLLVM = true;
          libc = "bionic";
        };

        droidpkgs = import nixpkgs-master {
          inherit system;
          crossSystem = {
            config = "aarch64-unknown-linux-android";
            useAndroidPrebuilt = true;
            androidSdkVersion = "28";
            androidNdkVersion = "27";
            useLLVM = true;
            libc = "bionic";
          };
          config = {
            allowUnfree = true;
          };
        };

        ndkComposition = droidpkgs.androidenv.composeAndroidPackages sdkargs;

        androidNdk = ndkComposition.androidsdk;

        # https://github.com/nixos/nixpkgs/issues/420029
        #
        # crosspkgs_arm = import nixpkgs  {
        #   inherit system;
        #   crossSystem = {
        #       config = "arm64-darwin";
        #   };
        #   config = {
        #     android_sdk.accept_license = true;
        #     allowUnfree = true;
        #   };
        # };
        buildToolsVersion = "36.0.0";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = [
            buildToolsVersion
            "36.0.0"
          ];
          platformVersions = [ "36" ];
          abiVersions = [
            "arm64-v8a"
          ];
        };
        unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
          overlays = [
            nix-vscode-extensions.overlays.default
          ];
        };
        master = import nixpkgs-master {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
          overlays = [
            nix-vscode-extensions.overlays.default
          ];
        };
        androidSdk = androidComposition.androidsdk;
        isMacos = system == "aarch64-darwin" || system == "x86_64-darwin";
      in
      {

        devShell =
          with pkgs;
          (if isMacos then mkShellNoCC else mkShell) rec {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";

            wot_dual =
              if system == "aarch64-darwin" || system == "x86_64-darwin" then
                pkgs.stdenv.mkDerivation {
                  name = "wot_dual";
                  src = ./.;
                  phases = [
                    "unpackPhase"
                    "installPhase"
                  ];
                  installPhase = ''
                    mkdir -p $out/lib
                    ${cctools}/bin/lipo -create ${botan3.out}/lib/libbotan-3.dylib ${crosspkgs.botan3.out}/lib/libbotan-3.dylib -output $out/lib/libbotan-3.dylib
                    ${cctools}/bin/lipo -create ${libiconv}/lib/libiconv.dylib ${crosspkgs.libiconv.out}/lib/libiconv.dylib -output $out/lib/libiconv.dylib
                    ${cctools}/bin/lipo -create ${libiconv}/lib/libcharset.dylib ${crosspkgs.libiconv.out}/lib/libcharset.dylib -output $out/lib/libcharset.dylib
                    ${cctools}/bin/lipo -create ${libiconv}/lib/libcharset.1.dylib ${crosspkgs.libiconv.out}/lib/libcharset.dylib -output $out/lib/libcharset.1.dylib
                    ${cctools}/bin/lipo -create ${libiconv}/lib/libcharset.1.dylib ${crosspkgs.libiconv.out}/lib/libcharset.dylib -output $out/lib/libcharset.1.dylib
                    ${cctools}/bin/lipo -create ${bzip2.out}/lib/libbz2.dylib ${crosspkgs.bzip2.out}/lib/libbz2.dylib -output $out/lib/libbz2.dylib
                    ${cctools}/bin/lipo -create ${libz.out}/lib/libz.dylib ${crosspkgs.libz.out}/lib/libz.dylib -output $out/lib/libz.dylib
                  '';
                  system = builtins.currentSystem;
                  buildInputs = [ apple-sdk_15 ];
                }
              else
                botan3;

            baseInputs = [
              wot_dual
              master.flutter
              androidSdk
              jdk17
              rustup
              # fish
              cmake
              ninja
              meson
              protobuf
              # unstable.vscode
              jdk
              nixfmt-rfc-style
              #llvm
              #clang
              fontconfig
              botan3
              #droidpkgs.botan3
              gradle
              capnproto
              #pkgs.darwin.apple_sdk_11_0.frameworks.Carbon
              #pkgs.darwin.apple_sdk_11_0.frameworks.WebKit
              #pkgs.darwin.apple_sdk_11_0.frameworks.Foundation
              #cocoapods
              #cctools
              pkg-config
              rust-analyzer
              nil
              nixd
              # unstable.zed-editor
              #xcbuild
              #  swiftPackages.Foundation
              #  swiftPackages.Dispatch
              #  crosspkgs.swiftPackages.Foundation
              #  crosspkgs.swiftPackages.Dispatch
            ];
            env =
              if isMacos then
                {
                  BOTAN_LIB_DIR = "${wot_dual.out}/lib";
                  #BOTAN_DROID_DIR="${droidpkgs.botan3.out}/lib";
                  LIBRARY_PATH = "${wot_dual.out}/lib";
                  DYLD_LIBRARY_PATH = "${wot_dual.out}/lib";
                  LD_LIBRARY_PATH = "${wot_dual.out}/lib";
                }
              else
                let

                  droidlibs = pkgs.stdenv.mkDerivation {
                    name = "droidlibs";
                    src = ./.;
                    phases = [
                      "unpackPhase"
                      "installPhase"
                    ];
                    installPhase = ''
                      mkdir -p $out
                      cp ${droidpkgs.botan3.out}/lib/* $out
                      cp ${droidpkgs.bzip2.out}/lib/* $out
                      cp ${droidpkgs.zlib.out}/lib/* $out
                      cp ${droidpkgs.buildPackages.androidndkPkgs_27.binaries}/toolchain/sysroot/usr/lib/libc++_shared.so $out
                    '';
                  };
                in
                {
                  BOTAN_LIB_DIR = "${botan3.out}/lib";
                  BOTAN_DROID_DIR = "${droidlibs.out}";
                  BOTAN_INCLUDE_DIR = "${botan3.dev}/include/botan-3";
                  LD_LIBRARY_PATH = "${botan3.out}/lib";
                };
            # myFlutter = unstable.flutter.overrideDerivation (oldAttrs: {
            #     name = oldAttrs.name;
            #     patches = oldAttrs.patches ++ [
            #       (fetchpatch2 {
            #         url = "https://spectrum-os.org/git/nixpkgs/plain/pkgs/development/compilers/flutter/patches/flutter3/move-cache.patch?id=30a8e2f43bd834eaed9a4a32cbbbdd0436351681";
            #         hash = "sha256-YJwMkp9SFwq1bD4Q4xYkV9StTiKB+48Z7LeaMpm1RM4=";
            #       })
            #     ];

            # });
            buildInputs =
              if isMacos then
                baseInputs
                ++ [
                  apple-sdk_15
                  crosspkgs.botan3
                  cctools
                ]
              else
                baseInputs
                ++ [
                  gtk3
                  bzip2
                ];
          };
      }
    );
}
