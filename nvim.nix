{ vimPlugins }:

{
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  withNodeJs = true;
  plugins = with vimPlugins; [
    nerdtree
    vim-devicons
    fzf-vim
    coc-nvim
    vim-sneak
    gruvbox
    vim-highlightedyank
    vim-surround
    vim-css-color
    vim-nix
  ];
  extraConfig = ''
    " Plugin Section
    " call plug#begin("~/.vim/plugged")
    " Plug 'preservim/nerdtree'
    " Plug 'ryanoasis/vim-devicons'
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'justinmk/vim-sneak'
    " Plug 'morhetz/gruvbox'
    " Plug 'gruvbox-community/gruvbox'
    " Plug 'machakann/vim-highlightedyank'
    " Plug 'tpope/vim-surround'
    " Plug 'ap/vim-css-color'
    " call plug#end()


    "Config Section
    " Colorscheme
    " autocmd vimenter * colorscheme gruvbox
    " set termguicolors
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    colorscheme gruvbox
    set background=dark

    " Suggested COC things
    set hidden
    set cmdheight=2
    set updatetime=300
    set shortmess+=c
    set nu rnu
    set ignorecase
    set smartcase

    if has("patch-8.1.1564")
      set signcolumn=number
    else
      set signcolumn=yes
    endif

    " Tab selection
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()

    " Enter acceptance
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    autocmd FileType json syntax match Comment +\/\/.\+$+


    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    let g:mapleader ="\<Space>"
    let g:highlightedyank_highlight_duration = 200

    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '-'
    let g:NERDTreeQuitOnOpen = 1
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeIgnore = []
    let g:NERDTreeStatusline = ${"''"}
    " Automaticaly close nvim if NERDTree is only thing left open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Toggle
    nnoremap <silent> <Leader>t :NERDTreeToggle<CR>

    nnoremap <silent> <Leader>p :GFiles<CR>
    nnoremap <silent> <Leader>fp :Files<CR>
    nnoremap <silent> <Leader>ff :Rg<CR>

    nnoremap <Leader>w :Format<CR>:w<CR>
    nmap <leader>rn <Plug>(coc-rename)
    map <Leader>q :q<CR>

    " Sneak
    map f <Plug>Sneak_f
    map F <Plug>Sneak_F
    map t <Plug>Sneak_t
    map T <Plug>Sneak_T

    " Window movement
    map <Leader>h :wincmd h<CR>
    map <Leader>j :wincmd j<CR>
    map <Leader>k :wincmd k<CR>
    map <Leader>l :wincmd l<CR>

    " Copy to clipboard
    map <Leader>y "+y

    " Redo with U instead of Ctrl+R
    nnoremap U <C-R>
  '';
}
