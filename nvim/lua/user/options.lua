-- vim options
local options = {
    backup = false,                 -- backup file
    swapfile = false,               -- swap file
    compatible = false,             -- incompatible with vi

    number = true,                 -- line number
    relativenumber = false,         -- use relative number

    tabstop = 4,                    -- one table four space
    expandtab = true,               -- convert tab to space
    shiftwidth = 4,                   -- the number of spaces that should be used for each level of indentation

    hlsearch = true,                -- hightlight search

    mouse = "a",                   -- allow mouse to click
    mousefocus = true,

    paste = true,                   -- allow paste
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
