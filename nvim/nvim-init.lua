
local cmd = vim.cmd
local g = vim.g

function on_attach(client, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  
  --buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	    -- Mappings

local opts = {noremap = true, silent = true}
	map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)

    map("n", "H" , "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    map("n", "<leader>clr", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>", opts)
    map("n", "<leader>ca", "<cmd>Telescope lsp_code_actions previewer=false<cr>", opts)
    map("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    map("n", "<leader>cD", "<cmd>Telescope lsp_references theme=get_dropdown <cr>", opts)
    map("n", "<leader>ch", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    map("n", "<leader>cn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    map("n", "<leader>cp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    map("n", "<leader>cs", "<cmd>Telescope lsp_dynamic_workspace_symbols theme=get_dropdown <cr>", opts)
    map("n", "<leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    map("n", "<leader>cx", "<cmd>TroubleToggle<cr>", opts)
    map("x", "<leader>ca", "<cmd>Telescope lsp_range_code_actions theme=get_dropdown<cr>", opts)
    map("i", "<C-a>", "<cmd>Telescope lsp_code_actions theme=get_dropdown<cr>", opts)
    map("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
end


local lspconf = require "lspconfig"
local servers = {"pyright" , "bashls", "rust_analyzer", "jsonls", "rnix"}
for k, lang in pairs(servers) do
    lspconf[lang].setup {
        root_dir = vim.loop.cwd,
        on_attach = on_attach,
        -- capabilities = capabilities,
    }
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

--require('lspconfig')['rust-analyzer'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--    -- Server-specific settings...
--    settings = {
--      ["rust-analyzer"] = {}
--    }
--}

--function M.utf8_config(config)
--  config.capabilities = config.capabilities or lsp.protocol.make_client_capabilities()
--  config.capabilities.offsetEncoding = {"utf-8", "utf-16"}
--  function config.on_init(client, result)
--    if result.offsetEncoding then
--      client.offset_encoding = result.offsetEncoding
--    end
--  end
--  return config
--end


require "lspconfig".rust_analyzer = {
    	cmd = {"rust-analyzer"};
    	filetypes = {"rust"};
	root_dir = function()
		return vim.loop.cwd()
	end,
	on_attach = on_attachl
    	--root_dir = util.root_pattern("Cargo.toml", "rust-project.json");
}


