{
  enable = true;
  defaultEditor = true;
  extraLuaConfig = "
    local set = vim.opt
    set.number = true
    set.relativenumber = true

    set.mouse = 'a'
    set.cursorline = false
    set.wrap = false
    --set.scroll = 8

    -- Search
    set.ignorecase = true
    set.smartcase = true

    -- Indnet
    set.tabstop = 2
    set.softtabstop = 2
    set.shiftwidth = 2
    set.expandtab = true

    set.autoindent = true
    set.smartindent = true

    -- Color Theme --> color.lua
    set.termguicolors = true
    set.signcolumn = 'yes'
    ";
}

