-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     pattern = { "markdown" },
--     callback = function(args)
--         vim.cmd([[syntax match codeblock "```" conceal cchar=═]])
--     end,
-- })
os.execute("export ZK_NOTEBOOK_DIR=" .. require("config").notes_home)
local opts = { silent = true, noremap = true }

vim.keymap.set("n", "<space>zs", function()
    local status_ok, telescope = pcall(require, "telescope")
    if status_ok then
        telescope.extensions.live_grep_args.live_grep_args({
            search_dirs = { require("config").notes_home },
            path_display = { "tail" },
        })
    end
end, opts)

vim.keymap.set("v", "<space>zs", function()
    local selected_text = require("utils.utils").get_visual_selection()
    selected_text = string.gsub(selected_text, "\n", "")
    local status_ok, telescope = pcall(require, "telescope")
    if status_ok then
        telescope.extensions.live_grep_args.live_grep_args({
            search_dirs = { require("config").notes_home },
            default_text = selected_text,
            path_display = { "tail" },
        })
    end
end, opts)

-- keymap("n", "<space>zf", function()
--     local status_ok, telescope = pcall(require, "telescope.builtin")
--     if status_ok then
--         telescope.find_files({
--             search_dirs = { require("config").notes_home },
--             path_display = { "tail" },
--         })
--     end
-- end, opts)
--
-- keymap("n", "<space>zt", function()
--     local status_ok, telescope = pcall(require, "telescope")
--     if status_ok then
--         telescope.extensions.live_grep_args.live_grep_args({
--             search_dirs = { require("config").notes_home },
--             default_text = "(^|\\s)#[A-Za-z\\u4e00-\\u9fff0-9_]+$",
--             path_display = { "tail" },
--         })
--         -- local bufnr = vim.api.nvim_get_current_buf()
--         -- require("telescope.actions").to_fuzzy_refine(bufnr)
--     end
-- end, opts)

local _M = {
    {
        "zk-org/zk-nvim",
        enabled = true,
        ft = { "markdown", "md" },
        config = function()
            require("zk").setup({
                -- can be "telescope", "fzf", "fzf_lua" or "select" (`vim.ui.select`)
                -- it's recommended to use "telescope", "fzf" or "fzf_lua"
                picker = "telescope",

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = {
                        -- cmd = { "zk", "lsp" },
                        -- name = "zk",
                        -- on_attach = function(_, bufnr)
                        --     local opts = { silent = true, noremap = true, buffer = bufnr }
                        --     local keymap = vim.keymap.set
                        --
                        --     -- keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
                        --     keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
                        -- end,
                    },

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = false,
                        filetypes = { "markdown" },
                    },
                },
            })
        end,
        keys = {
            { mode = "n", "<space>zf", "<cmd>ZkNotes<cr>" },
            { mode = "n", "<space>zl", "<cmd>ZkLinks<cr>" },
            { mode = "n", "<space>zt", "<cmd>ZkTags<cr>" },
        },
    },
    {
        "jakewvincent/mkdnflow.nvim",
        enabled = true,
        ft = { "markdown", "md" },
        config = function()
            require("mkdnflow").setup({

                modules = {
                    bib = true,
                    buffers = true,
                    conceal = true,
                    cursor = true,
                    folds = true,
                    links = true,
                    lists = true,
                    maps = true,
                    paths = true,
                    tables = true,
                    yaml = false,
                    cmp = false,
                },
                filetypes = { md = true, rmd = true, markdown = true },
                create_dirs = true,
                perspective = {
                    priority = "relative",
                    fallback = "current",
                    root_tell = false,
                    nvim_wd_heel = false,
                    update = false,
                },
                wrap = false,
                bib = {
                    default_path = nil,
                    find_in_root = true,
                },
                silent = false,
                cursor = {
                    jump_patterns = nil,
                },
                links = {
                    style = "wiki",
                    name_is_source = true,
                    conceal = true,
                    context = 0,
                    implicit_extension = nil,
                    transform_implicit = false,
                    transform_explicit = function(text)
                        return text
                        -- text = text:gsub(" ", "-")
                        -- text = text:lower()
                        -- text = os.date("%Y-%m-%d_") .. text
                        -- return text
                    end,
                },
                new_file_template = {
                    use_template = true,
                    template = [[ # {{ title }} ]],
                    placeholders = {
                        before = {
                            title = "link_title",
                            date = "os_date",
                        },
                        after = {},
                    },
                    -- template = "# {{ title }}",
                },
                to_do = {
                    symbols = { " ", "", "✔" },
                    update_parents = true,
                    not_started = " ",
                    in_progress = "",
                    complete = "✔",
                },
                tables = {
                    trim_whitespace = true,
                    format_on_move = true,
                    auto_extend_rows = true,
                    auto_extend_cols = false,
                    style = {
                        cell_padding = 1,
                        separator_padding = 1,
                        outer_pipes = true,
                        mimic_alignment = true,
                    },
                },
                -- syntax match todoCheckbox "\[\ \]" conceal cchar=
                yaml = {
                    bib = { override = false },
                },
                mappings = {
                    MkdnEnter = { { "n", "v" }, "gd" },
                    -- MkdnEnter = false,
                    MkdnTab = false,
                    MkdnSTab = false,
                    MkdnNextLink = { "n", "<Tab>" },
                    MkdnPrevLink = { "n", "<S-Tab>" },
                    MkdnNextHeading = { "n", "]]" },
                    MkdnPrevHeading = { "n", "[[" },
                    MkdnGoBack = { "n", "<BS>" },
                    MkdnGoForward = { "n", "<Del>" },
                    MkdnCreateLink = false, -- see MkdnEnter
                    MkdnCreateLinkFromClipboard = false, -- see MkdnEnter
                    MkdnFollowLink = false, -- see MkdnEnter
                    MkdnDestroyLink = { "n", "<M-CR>" },
                    MkdnTagSpan = { "v", "<M-CR>" },
                    MkdnMoveSource = { "n", "<F2>" },
                    MkdnYankAnchorLink = { "n", "yaa" },
                    MkdnYankFileAnchorLink = { "n", "yfa" },
                    MkdnIncreaseHeading = { "n", "+" },
                    MkdnDecreaseHeading = { "n", "-" },
                    MkdnToggleToDo = { { "n", "v", "i" }, "<c-space>" },
                    MkdnNewListItem = false,
                    MkdnNewListItemBelowInsert = { "n", "o" },
                    MkdnNewListItemAboveInsert = { "n", "O" },
                    MkdnExtendList = false,
                    MkdnUpdateNumbering = { "n", "<leader>nn" },
                    MkdnTableNextCell = { "i", "<Tab>" },
                    MkdnTablePrevCell = { "i", "<S-Tab>" },
                    MkdnTableNextRow = false,
                    MkdnTablePrevRow = { "i", "<M-CR>" },
                    MkdnTableNewRowBelow = { "n", "<leader>ir" },
                    MkdnTableNewRowAbove = { "n", "<leader>iR" },
                    MkdnTableNewColAfter = { "n", "<leader>ic" },
                    MkdnTableNewColBefore = { "n", "<leader>iC" },
                    MkdnFoldSection = { "n", "<leader>f" },
                    MkdnUnfoldSection = { "n", "<leader>F" },
                },
            })
        end,
    },
    {
        "dfendr/clipboard-image.nvim",
        enabled = false,
        ft = { "markdown" },
        config = function()
            require("clipboard-image").setup({
                -- Default configuration for all filetype
                default = {
                    img_dir = "images",
                    img_name = function()
                        return os.date("%Y-%m-%d-%H-%M-%S")
                    end, -- Example result: "2021-04-13-10-04-18"
                    affix = "<\n  %s\n>", -- Multi lines affix
                },
                -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
                -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
                -- Missing options from `markdown` field will be replaced by options from `default` field
                markdown = {
                    img_dir = { "src", "assets", "img" }, -- Use table for nested dir (New feature form PR #20)
                    img_dir_txt = "/assets/img",
                    img_handler = function(img) -- New feature from PR #22
                        local script = string.format('./image_compressor.sh "%s"', img.path)
                        os.execute(script)
                    end,
                },
            })

            vim.keymap.set("n", "<m-v>", function()
                require("clipboard-image.paste").paste_img()
            end, opts)
        end,
    },
    {
        "3rd/image.nvim",
        enabled = false,
        ft = { "markdown" },
        config = function()
            if vim.g.neovide then
                return
            end

            -- -- for markdown preview
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

            -- macos
            -- install lua5.1 manully
            -- install luarocks manully
            -- brew install imagemagick
            -- luarocks --local install luarocks-fetch-gitrec
            -- luarocks --local --lua-version 5.1 install magick
            -- default config
            require("image").setup({
                backend = "kitty",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                        resolve_image_path = function(document_path, image_path, fallback)
                            -- document_path is the path to the file that contains the image
                            -- image_path is the potentially relative path to the image. for
                            -- markdown it's `![](this text)`

                            -- you can call the fallback function to get the default behavior
                            return fallback(document_path, image_path)
                        end,
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "norg" },
                    },
                },
                max_width = 200,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
            })
        end,
    },
    {
        "jbyuki/venn.nvim",
        lazy = true,
        -- config = true,
        keys = {
            {
                mode = "n",
                "<leader>vv",
                function()
                    local venn_enabled = vim.inspect(vim.b.venn_enabled)
                    if venn_enabled == "nil" then
                        vim.b.venn_enabled = true
                        -- vim.cmd([[setlocal ve=all]])
                        vim.api.nvim_set_option_value("ve", "all", { scope = "local" })
                        vim.api.nvim_set_option_value("wrap", false, { scope = "local" })
                        -- draw a line on HJKL keystokes
                        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                        -- draw a box by pressing "f" with visual selection
                        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
                    else
                        -- vim.cmd([[setlocal ve=]])
                        -- vim.cmd([[mapclear <buffer>]])
                        vim.api.nvim_set_option_value("ve", "", { scope = "local" })
                        vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
                        vim.api.nvim_command("mapclear <buffer>")
                        vim.b.venn_enabled = nil
                    end
                end,
            },
        },
    },
    {
        "jbyuki/nabla.nvim",
        enabled = false,
        ft = { "markdown" },
        config = function()
            vim.api.nvim_create_augroup("vimelua_markdown_autocommands", {})
            vim.api.nvim_create_autocmd("BufEnter", {
                group = "vimelua_markdown_autocommands",
                pattern = "*.md",
                callback = function()
                    require("nabla").enable_virt({
                        autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                        silent = true, -- silents error messages
                    })
                end,
            })
            vim.api.nvim_create_autocmd("BufLeave", {
                group = "vimelua_markdown_autocommands",
                pattern = "*.md",
                callback = function()
                    require("nabla").disable_virt()
                end,
            })
        end,
        keys = {
            {
                mode = "n",
                "<leader>nt",
                function()
                    require("nabla").toggle_virt({
                        autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                        silent = true, -- silents error messages
                    })
                end,
            },
        },
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        enabled = true,
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup({
                markdown_query = [[
        (atx_heading [
            (atx_h1_marker)
            (atx_h2_marker)
            (atx_h3_marker)
            (atx_h4_marker)
            (atx_h5_marker)
            (atx_h6_marker)
        ] @heading)

        (fenced_code_block) @code

        [
            (list_marker_plus)
            (list_marker_minus)
            (list_marker_star)
        ] @list_marker

        (block_quote (block_quote_marker) @quote_marker)
        (block_quote (paragraph (inline (block_continuation) @quote_marker)))

        (pipe_table_header) @table_head
        (pipe_table_delimiter_row) @table_delim
        (pipe_table_row) @table_row
    ]],
                -- Filetypes this plugin will run on
                file_types = { "markdown" },
                -- vim modes that will show a rendered view of the markdown file, all other
                -- modes will be uneffected by this plugin
                render_modes = { "n", "c" },
                -- Characters that will replace the # at the start of headings
                headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- Character to use for the bullet point in lists
                bullet = "○",
                -- Character that will replace the > at the start of block quotes
                quote = "┃",
                -- Define the highlight groups to use when rendering various components
                highlights = {
                    heading = {
                        -- Background of heading line
                        backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
                        -- Foreground of heading character only
                        foregrounds = {
                            "markdownH1",
                            "markdownH2",
                            "markdownH3",
                            "markdownH4",
                            "markdownH5",
                            "markdownH6",
                        },
                    },
                    -- Code blocks
                    code = "ColorColumn",
                    -- Bullet points in list
                    bullet = "Normal",
                    table = {
                        -- Header of a markdown table
                        head = "@markup.heading",
                        -- Non header rows in a markdown table
                        row = "Normal",
                    },
                    -- LaTeX blocks
                    latex = "@markup.math",
                    -- Quote character in a block quote
                    quote = "@markup.quote",
                },
            })
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        enabled = false,
        ft = { "markdown" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("headlines").setup({
                markdown = {
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
                    ),
                    headline_highlights = { "Headline" },
                    bullet_highlights = {
                        "@text.title.1.marker.markdown",
                        "@text.title.2.marker.markdown",
                        "@text.title.3.marker.markdown",
                        "@text.title.4.marker.markdown",
                        "@text.title.5.marker.markdown",
                        "@text.title.6.marker.markdown",
                    },
                    bullets = { "◉", "○", "✸", "✿" },
                    codeblock_highlight = "CodeBlock",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = true,
                    fat_headline_upper_string = "▃",
                    fat_headline_lower_string = "🬂",
                },
                rmd = {
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
                    ),
                    treesitter_language = "markdown",
                    headline_highlights = { "Headline" },
                    bullet_highlights = {
                        "@text.title.1.marker.markdown",
                        "@text.title.2.marker.markdown",
                        "@text.title.3.marker.markdown",
                        "@text.title.4.marker.markdown",
                        "@text.title.5.marker.markdown",
                        "@text.title.6.marker.markdown",
                    },
                    bullets = { "◉", "○", "✸", "✿" },
                    codeblock_highlight = "CodeBlock",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = true,
                    fat_headline_upper_string = "▃",
                    fat_headline_lower_string = "🬂",
                },
                norg = {
                    query = vim.treesitter.query.parse(
                        "norg",
                        [[
                [
                    (heading1_prefix)
                    (heading2_prefix)
                    (heading3_prefix)
                    (heading4_prefix)
                    (heading5_prefix)
                    (heading6_prefix)
                ] @headline

                (weak_paragraph_delimiter) @dash
                (strong_paragraph_delimiter) @doubledash

                ([(ranged_tag
                    name: (tag_name) @_name
                    (#eq? @_name "code")
                )
                (ranged_verbatim_tag
                    name: (tag_name) @_name
                    (#eq? @_name "code")
                )] @codeblock (#offset! @codeblock 0 0 1 0))

                (quote1_prefix) @quote
            ]]
                    ),
                    headline_highlights = { "Headline" },
                    bullet_highlights = {
                        "@neorg.headings.1.prefix",
                        "@neorg.headings.2.prefix",
                        "@neorg.headings.3.prefix",
                        "@neorg.headings.4.prefix",
                        "@neorg.headings.5.prefix",
                        "@neorg.headings.6.prefix",
                    },
                    bullets = { "◉", "○", "✸", "✿" },
                    codeblock_highlight = "CodeBlock",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    doubledash_highlight = "DoubleDash",
                    doubledash_string = "=",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = true,
                    fat_headline_upper_string = "▃",
                    fat_headline_lower_string = "🬂",
                },
            --     org = {
            --         query = vim.treesitter.query.parse(
            --             "org",
            --             [[
            --     (headline (stars) @headline)
            --
            --     (
            --         (expr) @dash
            --         (#match? @dash "^-----+$")
            --     )
            --
            --     (block
            --         name: (expr) @_name
            --         (#match? @_name "(SRC|src)")
            --     ) @codeblock
            --
            --     (paragraph . (expr) @quote
            --         (#eq? @quote ">")
            --     )
            -- ]]
            --         ),
            --         headline_highlights = { "Headline" },
            --         bullet_highlights = {
            --             "@org.headline.level1",
            --             "@org.headline.level2",
            --             "@org.headline.level3",
            --             "@org.headline.level4",
            --             "@org.headline.level5",
            --             "@org.headline.level6",
            --             "@org.headline.level7",
            --             "@org.headline.level8",
            --         },
            --         bullets = { "◉", "○", "✸", "✿" },
            --         codeblock_highlight = "CodeBlock",
            --         dash_highlight = "Dash",
            --         dash_string = "-",
            --         quote_highlight = "Quote",
            --         quote_string = "┃",
            --         fat_headlines = true,
            --         fat_headline_upper_string = "▃",
            --         fat_headline_lower_string = "🬂",
            --     },
            })
        end,
    },
}

return _M
