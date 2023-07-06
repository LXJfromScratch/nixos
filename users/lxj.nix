{config, pkgs, ...}:
{
	home.username = "lxj";
	home.homeDirectory = "/home/lxj";
	home.stateVersion = "23.05";
	home.packages = [ pkgs.atool pkgs.httpie ];
	programs = {
		#neovim = import ./apps/neovim.nix;		
		neovim.enable = true;
    git = {
			enable = true;
		};
		htop.enable = true;
    java = {
      enable = true;
      package = pkgs.openjdk17;
    };
    obs-studio = {
      enable = true;
    };
    google-chrome = {
      enable = true;
    };
	}; 
}
