vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd VimEnter * :packadd cfilter
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufWritePost ~/.config/nvim/*
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal spelllang=en,pt_br
    autocmd FileType markdown setlocal spellfile=~/.local/share/nvim/site/pack/packer/start/vim-spell-pt-br/spell/pt.utf-8.add
    autocmd FileType markdown setlocal spellfile+=~/.config/nvim/spell/en.utf-8.add

    autocmd FileType markdown setlocal foldlevel=99
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _vimwiki
    autocmd!
    autocmd BufWinEnter ~/vimwiki/* :set updatetime=5000
    autocmd BufWinLeave ~/vimwiki/* :set updatetime=300
  augroup end

]]

function _G.execute_external_command()
  local shell_error = vim.v.shell_error

  if vim.v.shell_error == 0 then
    shell_error = "success"
  else
    shell_error = "error"
  end

  local output = vim.g._command_output
  vim.g._command_output = nil

  output = {
    shell_error = shell_error,
    message = output
  }
  return output
end

function _G.git_pull()
  vim.cmd("let g:_command_output=system('git pull --ff-only')")

  return _G.execute_external_command()
end

function _G.git_commit()
  vim.cmd("let g:_command_output=system('git add --all  && git commit -m \"🤖 - Auto commit of \"'..shellescape(expand(\"<afile>:t\")))")

  return _G.execute_external_command()
end

vim.cmd('autocmd BufWinEnter ~/vimwiki/* lua vim.notify(git_pull()["message"], git_pull()["shell_error"],  { title = "GIT PULL"})')
vim.cmd('autocmd CursorHold,BufWinLeave ~/vimwiki/* lua vim.notify(git_commit()["message"], "success", {title = "GIT COMMIT"})')


-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
