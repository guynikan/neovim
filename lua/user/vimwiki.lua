vim.g.markdown_folding = 1
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {
  {
    path = '~/vimwiki/',
    path_html = '~/vimwiki/HTML/',
    auto_export = 0,
    index = 'home',
    syntax = 'markdown',
    ext = '.md',
    auto_toc = 1,
    maxhi = 1,
    nested_syntaxes = { python = 'python',  js = 'javascript'},
    list_margin = -1
  }
}
