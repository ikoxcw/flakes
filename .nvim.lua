-- vim.o.number = false
local nvim_lsp = require("lspconfig")
nvim_lsp.nixd.setup({
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake ("git+file://" + toString ./.)).inputs.nixpkgs { }',
			},
			formatting = {
				command = { "nixpkgs-fmt" },
			},
			options = {
				nixos = {
					expr = 'let flake = builtins.getFlake ("git+file://" + toString ./.); in flake.nixosConfigurations.nixos.options // flake.nixosConfigurations.cutw.options',
				},
				home_manager = {
					expr = 'let flake = builtins.getFlake ("git+file://" + toString ./.); in flake.homeConfigurations."kotori@nixos".options // flake.homeConfigurations."kotori@cutw".options',
				},
				flake_parts = {
					expr = 'let flake = builtins.getFlake ("git+file://" + toString ./.); in flake.debug.options // flake.currentSystem.options',
				},
			},
		},
	},
})
