{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.yazi.overlays.default ];
}
