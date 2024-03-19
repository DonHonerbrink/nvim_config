# vim_config
My personal vim configuration



Installer Packer - NVIM package manager:

    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

Clone NVIM config:

	git clone https://github.com/DonHonerbrink/nvim_config.git ~/.config/nvim

Install NVIM config packages:

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 
	
Install clangd - autocompletion:

    Install clangd using your distribution package manger (I use arch BTW)
    start neovim



