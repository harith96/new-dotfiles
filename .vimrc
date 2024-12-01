" ----------------------------------------
"  VimPulg Config
" ----------------------------------------

" Automatic installation of vim-plug, if it's not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically install missing plugins on startup
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

" Plugins
silent! if plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'        " Linting plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/gruvbox-material'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FuzzySearch
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'          " Git wrapper

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'ryanoasis/vim-devicons'      " Dev icons

Plug 'tpope/vim-commentary'        " Vim commentary
Plug 'tpope/vim-surround'          " Sorround content
Plug 'vim-airline/vim-airline'     " Status bar
Plug 'junkblocker/git-time-lapse'  " Traverse git history
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'gelguy/wilder.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'frazrepo/vim-rainbow'
Plug 'github/copilot.vim'
" Plug 'pangloss/vim-javascript'
call plug#end()
endif


"---------------------------------------
" Un-do Config
"---------------------------------------

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"---------------------------------------
" Manual Config
"---------------------------------------

set number
set encoding=UTF-8
set autoindent

set smartindent
set tabstop=4
set shiftwidth=4

set mouse=a
set background=dark
colorscheme gruvbox-material

set pastetoggle=<f5>

set foldmethod=syntax
set foldlevelstart=99
set splitright
set splitbelow
set hidden
set termwinsize=20x0

set hlsearch 
set shortmess-=S
set termguicolors
set clipboard=unnamedplus

let mapleader = ","
let g:mapleader = ","

nnoremap <silent><nowait> <space><Enter> i<Enter><Esc>

nnoremap <C-s> :wa<CR>
inoremap <C-s> <Esc>:wa<CR>i
nnoremap <C-q> :wqa<CR>

nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
nnoremap bd :bd<CR>
nnoremap <C-b> :Buffers<CR>

vnoremap <silent><nowait> <C-y> "+y
nnoremap <silent><nowait> <C-p> "+p
vnoremap <silent><nowait> <C-p> "+p
inoremap <silent><nowait> <C-p> <Esc>"+pi
nnoremap <silent><nowait> <C-l> :let @+ = expand("%")<CR> 
nnoremap <silent><nowait> vs :vsplit<CR>
nnoremap <silent><nowait> Q q
nnoremap <silent><nowait> q :q<CR>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap ws /\v<><Left>
vnoremap s /\%V

nnoremap <silent><nowait> sl :noh<CR> 
vnoremap <silent><nowait> sl :noh<CR> 

nnoremap so :so ~/.vimrc<CR>
nnoremap el <End>x<Down>
" delete without yanking
vnoremap <nowait> x "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

command! BufCurOnly execute '%bdelete|edit#|bdelete#'

"---------------------------------------
" Wilder Config
"---------------------------------------

call wilder#setup({'modes': [':', '/', '?']})

"---------------------------------------
" Git Time Lapse Config
"---------------------------------------

nmap <Leader>gt <Plug>(git-time-lapse)

"---------------------------------------
" Vim Airline Config
"---------------------------------------

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#bufferline#overwrite_variables=0
let g:airline_powerline_fonts = 1


"---------------------------------------
" FZF Config
"---------------------------------------

nnoremap <silent> B :Buffers<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '-i', fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . ' --bind "alt-a:select-all,alt-d:deselect-all"'
"---------------------------------------
" NERDTree Config
"---------------------------------------

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeWinSize=50
let g:NERDTreeGitStatusUseNerdFonts = 1


"---------------------------------------
" Rainbow Config
"---------------------------------------
let g:rainbow_active = 1

"---------------------------------------
" Fugitive Config
"---------------------------------------

nmap G :Gedit :<CR>6j

"---------------------------------------
" CoC Config
"---------------------------------------
hi CocErrorHighlight ctermfg=red guifg=#c4384b gui=underline cterm=underline
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=underline term=underline
" hi CocInfoHighlight ctermfg=yellow guifg=#c4ab39 gui=underline term=underline

let g:coc_global_extensions = [
      \'coc-spell-checker',
      \'coc-snippets',
      \'coc-prettier',
      \'coc-eslint',
      \'coc-tsserver',
      \'coc-json',
      \'@yaegassy/coc-tailwindcss3',
      \]

nnoremap F :Files<CR>

nnoremap <nowait><silent> <leader>p :Format<CR>

set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=100
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ctrl-space to trigger auto completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)


" Use CTRL-a for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-a> <Plug>(coc-range-select)
xmap <silent> <C-a> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>d  :<C-u>CocList -S --ignore-case outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I -S --ignore-case symbols<cr>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

augroup strdr4605
  autocmd!
  autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
augroup END

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
