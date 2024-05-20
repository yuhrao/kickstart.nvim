runtime autoload/dracula_pro.vim

let g:dracula_pro#palette.comment   = ['#655C95', 103]
" This cterm value adjusted by hand. Conversion function gives 188, which is
" used for bgdark{,er}. 189 also has a "bluer" feel for selections.
let g:dracula_pro#palette.selection = ['#D6D6E1', 189]
let g:dracula_pro#palette.subtle    = ['#D1D2D8', 188]

let g:dracula_pro#palette.bglighter = ['#FEFEFE', 231]
let g:dracula_pro#palette.bglight   = ['#EDEFF4', 231]
" This cterm value adjusted by hand. Conversion function gives 231 again, which
" is 0xFFFFFF. The manually-adjusted value 255 is 0xEEEEEE for some slight
" contrast between bglight{,er} and bg.
let g:dracula_pro#palette.bg        = ['#EFF1F5', 255]
let g:dracula_pro#palette.bgdark    = ['#D5DAE4', 188]
let g:dracula_pro#palette.bgdarker  = ['#C0C5D1', 188]

" This cterm value adjusted by hand. Conversion function gives 66, which is too
" blue compared to the grey. 242 (0x6C6C6C) is visually closer.
let g:dracula_pro#palette.fg        = ['#4C4F69', 242]

let g:dracula_pro#palette.cyan      = ['#0073B3',  32]
let g:dracula_pro#palette.green     = ['#1E7E09',  64]
let g:dracula_pro#palette.orange    = ['#A14D16', 130]
let g:dracula_pro#palette.pink      = ['#AF306F', 132]
let g:dracula_pro#palette.purple    = ['#634ECD', 104]
let g:dracula_pro#palette.red       = ['#CF372B', 167]
let g:dracula_pro#palette.yellow    = ['#867113',  94]

" ANSI
" black
let g:dracula_pro#palette.color_0  = '#21222C'
" dark red
let g:dracula_pro#palette.color_1  = g:dracula_pro#palette.red[0]
" dark green
let g:dracula_pro#palette.color_2  = g:dracula_pro#palette.green[0]
" brown/yellow
let g:dracula_pro#palette.color_3  = g:dracula_pro#palette.yellow[0]
" dark blue
let g:dracula_pro#palette.color_4  = g:dracula_pro#palette.purple[0]
" dark magenta
let g:dracula_pro#palette.color_5  = g:dracula_pro#palette.pink[0]
" dark cyan
let g:dracula_pro#palette.color_6  = g:dracula_pro#palette.cyan[0]
" light grey/white
let g:dracula_pro#palette.color_7  = g:dracula_pro#palette.fg[0]
" dark grey
let g:dracula_pro#palette.color_8  = g:dracula_pro#palette.comment[0]
" (bright) red
let g:dracula_pro#palette.color_9  = '#D74B3B'
" (bright) green
let g:dracula_pro#palette.color_10 = '#357B2F'
" (bright) yellow
let g:dracula_pro#palette.color_11 = '#C4A41C'
" (bright) blue/purple
let g:dracula_pro#palette.color_12 = '#6F63AF'
" (bright) magenta/pink
let g:dracula_pro#palette.color_13 = '#A1557B'
" bright cyan
let g:dracula_pro#palette.color_14 = '#2D796C'
" white
let g:dracula_pro#palette.color_15 = '#E6E9EF'

runtime colors/dracula_pro_base.vim

" Fix Pmenu. The BgDark is too close to the selection value.
highlight! link Pmenu      DraculaBgLighter
highlight! link PmenuSbar  DraculaBgLighter

let g:colors_name = 'alucard'
