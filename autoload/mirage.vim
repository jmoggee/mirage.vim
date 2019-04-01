" [mirage.vim](https://github.com/jmoggee/mirage.vim/)

let s:overrides = get(g:, "mirage_color_overrides", {})

let s:colors = {
      \ "red": get(s:overrides, "red", { "gui": "#ff5370", "cterm": "204", "cterm16": "1" }),
      \ "light_red": get(s:overrides, "light_red", { "gui": "#ff9999", "cterm": "196", "cterm16": "9" }), 
      \ "green": get(s:overrides, "green", { "gui": "#8acf95", "cterm": "114", "cterm16": "2" }),
      \ "yellow": get(s:overrides, "yellow", { "gui": "#ffcb6b", "cterm": "180", "cterm16": "3" }),
      \ "orange": get(s:overrides, "orange", { "gui": "#ffb38c", "cterm": "173", "cterm16": "11" }),
      \ "blue": get(s:overrides, "blue", { "gui": "#7fb5ff", "cterm": "39", "cterm16": "4" }),
      \ "muted_blue": get(s:overrides, "muted_blue", { "gui": "#5e82b3", "cterm": "39", "cterm16": "4" }),
      \ "pink": get(s:overrides, "pink", { "gui": "#ddaefe", "cterm": "170", "cterm16": "5" }),
      \ "cyan": get(s:overrides, "cyan", { "gui": "#70c2cc", "cterm": "38", "cterm16": "6" }),
      \ "white": get(s:overrides, "white", { "gui": "#bbbbbb", "cterm": "145", "cterm16": "7" }),
      \ "bright_white": get(s:overrides, "bright_white", { "gui": "#eeeeee", "cterm": "145", "cterm16": "7" }),
      \ "black": get(s:overrides, "black", { "gui": "#1c2838", "cterm": "235", "cterm16": "0" }),
      \ "visual_black": get(s:overrides, "visual_black", { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }),
      \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#42587e", "cterm": "59", "cterm16": "15" }),
      \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#28354d", "cterm": "238", "cterm16": "15" }),
      \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }),
      \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "15" }),
      \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }),
      \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#5e82b3", "cterm": "59", "cterm16": "15" }),
      \}

function! mirage#GetColors()
  return s:colors
endfunction
