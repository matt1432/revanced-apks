vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id);
        if not client or client.name ~= 'bashls' then
            return;
        end

        local bufnr = args.buf;

        vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return;
            end

            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd('setlocal ts=4 sw=4 sts=4 noexpandtab');
                vim.treesitter.start(bufnr);
            end);
        end, 100);
    end,
});
