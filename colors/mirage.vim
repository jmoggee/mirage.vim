" vim:fdm=marker
" Vim Color File
" Name:       mirage.vim
" Maintainer: https://github.com/jmoggee/mirage.vim/
" License:    The MIT License (MIT)
" Based On: https://github.com/joshdick/onedark.vim/

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="mirage"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/jmoggee/mirage.vim/blob/master/README.md >
" for more information.)
if !exists("g:mirage_termcolors")
  let g:mirage_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:mirage_terminal_italics")
  let g:mirage_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `mirage#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from mirage#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? s:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:mirage_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:mirage_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! mirage#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! mirage#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:colors = mirage#GetColors()

let s:red = s:colors.red
let s:light_red = s:colors.light_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:orange = s:colors.orange
let s:blue = s:colors.blue
let s:muted_blue = s:colors.muted_blue
let s:pink = s:colors.pink
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:bright_white = s:colors.bright_white
let s:black = s:colors.black
let s:visual_black = s:colors.visual_black " Black out selected text in 16-color visual mode
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit

" }}}

" Terminal Colors {{{

let g:terminal_ansi_colors = [
  \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:white.gui,
  \ s:visual_grey.gui, s:light_red.gui, s:green.gui, s:orange.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:comment_grey.gui
\]

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:orange }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:orange }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:orange }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:pink }) " any statement
call s:h("Conditional", { "fg": s:pink }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:pink }) " for, do, while, etc.
call s:h("Label", { "fg": s:pink }) " case, default, etc.
call s:h("Operator", { "fg": s:pink }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red }) " any other keyword
call s:h("Exception", { "fg": s:pink }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:pink }) " preprocessor #define
call s:h("Macro", { "fg": s:pink }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:pink }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'mirage_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:white, "bg": s:black }) " normal text
call s:h("Pmenu", { "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:black, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:pink }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:orange }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:orange }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:orange }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:visual_black, "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" Vim
call s:h("helpExample", { "fg": s:bright_white })

" CSS
call s:h("cssAttrComma", { "fg": s:pink })
call s:h("cssAttributeSelector", { "fg": s:green })
call s:h("cssBraces", { "fg": s:white })
call s:h("cssClassName", { "fg": s:orange })
call s:h("cssClassNameDot", { "fg": s:orange })
call s:h("cssDefinition", { "fg": s:pink })
call s:h("cssFontAttr", { "fg": s:orange })
call s:h("cssFontDescriptor", { "fg": s:pink })
call s:h("cssFunctionName", { "fg": s:blue })
call s:h("cssIdentifier", { "fg": s:blue })
call s:h("cssImportant", { "fg": s:pink })
call s:h("cssInclude", { "fg": s:white })
call s:h("cssIncludeKeyword", { "fg": s:pink })
call s:h("cssMediaType", { "fg": s:orange })
call s:h("cssProp", { "fg": s:white })
call s:h("cssPseudoClassId", { "fg": s:orange })
call s:h("cssSelectorOp", { "fg": s:pink })
call s:h("cssSelectorOp2", { "fg": s:pink })
call s:h("cssTagName", { "fg": s:red })

" Fish Shell
call s:h("fishKeyword", { "fg": s:pink })
call s:h("fishConditional", { "fg": s:pink })

" Go
call s:h("goDeclaration", { "fg": s:pink })

" HTML
call s:h("htmlTitle", { "fg": s:white })
call s:h("htmlArg", { "fg": s:orange, "cterm": "italic", "gui": "italic" })
call s:h("htmlEndTag", { "fg": s:white })
call s:h("htmlH1", { "fg": s:white })
call s:h("htmlLink", { "fg": s:pink })
call s:h("htmlSpecialChar", { "fg": s:orange })
call s:h("htmlSpecialTagName", { "fg": s:red })
call s:h("htmlTag", { "fg": s:white })
call s:h("htmlTagName", { "fg": s:light_red })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:white })
call s:h("javaScriptFunction", { "fg": s:pink })
call s:h("javaScriptIdentifier", { "fg": s:pink })
call s:h("javaScriptNull", { "fg": s:orange })
call s:h("javaScriptNumber", { "fg": s:orange })
call s:h("javaScriptRequire", { "fg": s:cyan })
call s:h("javaScriptReserved", { "fg": s:pink })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:pink })
call s:h("jsClassKeyword", { "fg": s:pink })
call s:h("jsClassMethodType", { "fg": s:pink })
call s:h("jsDocParam", { "fg": s:blue })
call s:h("jsDocTags", { "fg": s:pink })
call s:h("jsExport", { "fg": s:pink, "cterm": "italic", "gui": "italic" })
call s:h("jsExportDefault", { "fg": s:pink, "cterm": "italic", "gui": "italic" })
call s:h("jsExtendsKeyword", { "fg": s:pink, "cterm": "italic", "gui": "italic" })
call s:h("jsFrom", { "fg": s:pink, "cterm": "italic", "gui": "italic" })
call s:h("jsFuncCall", { "fg": s:blue })
call s:h("jsFunction", { "fg": s:pink })
call s:h("jsGenerator", { "fg": s:yellow })
call s:h("jsGlobalObjects", { "fg": s:yellow })
call s:h("jsImport", { "fg": s:pink, "cterm": "italic", "gui": "italic" })
call s:h("jsModuleAs", { "fg": s:pink })
call s:h("jsModuleWords", { "fg": s:pink })
call s:h("jsModules", { "fg": s:pink })
call s:h("jsNull", { "fg": s:orange })
call s:h("jsOperator", { "fg": s:pink })
call s:h("jsStorageClass", { "fg": s:pink })
call s:h("jsSuper", { "fg": s:red })
call s:h("jsTemplateBraces", { "fg": s:light_red })
call s:h("jsTemplateVar", { "fg": s:green })
call s:h("jsThis", { "fg": s:red })
call s:h("jsUndefined", { "fg": s:orange })
call s:h("jsObjectKey", { "fg": s:cyan })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:pink })
call s:h("javascriptClassExtends", { "fg": s:pink })
call s:h("javascriptClassKeyword", { "fg": s:pink })
call s:h("javascriptDocNotation", { "fg": s:pink })
call s:h("javascriptDocParamName", { "fg": s:blue })
call s:h("javascriptDocTags", { "fg": s:pink })
call s:h("javascriptEndColons", { "fg": s:white })
call s:h("javascriptExport", { "fg": s:pink })
call s:h("javascriptFuncArg", { "fg": s:white })
call s:h("javascriptFuncKeyword", { "fg": s:pink })
call s:h("javascriptIdentifier", { "fg": s:red })
call s:h("javascriptImport", { "fg": s:pink })
call s:h("javascriptMethodName", { "fg": s:white })
call s:h("javascriptObjectLabel", { "fg": s:white })
call s:h("javascriptOpSymbol", { "fg": s:cyan })
call s:h("javascriptOpSymbols", { "fg": s:cyan })
call s:h("javascriptPropertyName", { "fg": s:green })
call s:h("javascriptTemplateSB", { "fg": s:light_red })
call s:h("javascriptVariable", { "fg": s:pink })

" JSON
call s:h("jsonCommentError", { "fg": s:white })
call s:h("jsonKeyword", { "fg": s:red })
call s:h("jsonBoolean", { "fg": s:orange })
call s:h("jsonNumber", { "fg": s:orange })
call s:h("jsonQuote", { "fg": s:white })
call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:green })
call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:pink })
call s:h("lessAmpersandChar", { "fg": s:white })
call s:h("lessClass", { "fg": s:orange })

" Markdown
call s:h("markdownCode", { "fg": s:green })
call s:h("markdownCodeBlock", { "fg": s:green })
call s:h("markdownCodeDelimiter", { "fg": s:green })
call s:h("markdownHeadingDelimiter", { "fg": s:red })
call s:h("markdownRule", { "fg": s:comment_grey })
call s:h("markdownHeadingRule", { "fg": s:comment_grey })
call s:h("markdownH1", { "fg": s:red })
call s:h("markdownH2", { "fg": s:red })
call s:h("markdownH3", { "fg": s:red })
call s:h("markdownH4", { "fg": s:red })
call s:h("markdownH5", { "fg": s:red })
call s:h("markdownH6", { "fg": s:red })
call s:h("markdownIdDelimiter", { "fg": s:pink })
call s:h("markdownId", { "fg": s:pink })
call s:h("markdownBlockquote", { "fg": s:comment_grey })
call s:h("markdownItalic", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("markdownBold", { "fg": s:orange, "gui": "bold", "cterm": "bold" })
call s:h("markdownListMarker", { "fg": s:red })
call s:h("markdownOrderedListMarker", { "fg": s:red })
call s:h("markdownIdDeclaration", { "fg": s:blue })
call s:h("markdownLinkText", { "fg": s:blue })
call s:h("markdownLinkDelimiter", { "fg": s:white })
call s:h("markdownUrl", { "fg": s:pink })

" Perl
call s:h("perlFiledescRead", { "fg": s:green })
call s:h("perlFunction", { "fg": s:pink })
call s:h("perlMatchStartEnd",{ "fg": s:blue })
call s:h("perlMethod", { "fg": s:pink })
call s:h("perlPOD", { "fg": s:comment_grey })
call s:h("perlSharpBang", { "fg": s:comment_grey })
call s:h("perlSpecialString",{ "fg": s:cyan })
call s:h("perlStatementFiledesc", { "fg": s:red })
call s:h("perlStatementFlow",{ "fg": s:red })
call s:h("perlStatementInclude", { "fg": s:pink })
call s:h("perlStatementScalar",{ "fg": s:pink })
call s:h("perlStatementStorage", { "fg": s:pink })
call s:h("perlSubName",{ "fg": s:yellow })
call s:h("perlVarPlain",{ "fg": s:blue })

" PHP
call s:h("phpVarSelector", { "fg": s:red })
call s:h("phpOperator", { "fg": s:white })
call s:h("phpParent", { "fg": s:white })
call s:h("phpMemberSelector", { "fg": s:white })
call s:h("phpType", { "fg": s:pink })
call s:h("phpKeyword", { "fg": s:pink })
call s:h("phpClass", { "fg": s:yellow })
call s:h("phpUseClass", { "fg": s:white })
call s:h("phpUseAlias", { "fg": s:white })
call s:h("phpInclude", { "fg": s:pink })
call s:h("phpClassExtends", { "fg": s:green })
call s:h("phpDocTags", { "fg": s:white })
call s:h("phpFunction", { "fg": s:blue })
call s:h("phpFunctions", { "fg": s:cyan })
call s:h("phpMethodsVar", { "fg": s:orange })
call s:h("phpMagicConstants", { "fg": s:orange })
call s:h("phpSuperglobals", { "fg": s:red })
call s:h("phpConstants", { "fg": s:orange })

" Ruby
call s:h("rubyBlockParameter", { "fg": s:red})
call s:h("rubyBlockParameterList", { "fg": s:red })
call s:h("rubyClass", { "fg": s:pink})
call s:h("rubyConstant", { "fg": s:yellow})
call s:h("rubyControl", { "fg": s:pink })
call s:h("rubyEscape", { "fg": s:red})
call s:h("rubyFunction", { "fg": s:blue})
call s:h("rubyGlobalVariable", { "fg": s:red})
call s:h("rubyInclude", { "fg": s:blue})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:red})
call s:h("rubyInstanceVariable", { "fg": s:red})
call s:h("rubyInterpolation", { "fg": s:cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:red })
call s:h("rubyInterpolationDelimiter", { "fg": s:red})
call s:h("rubyRegexp", { "fg": s:cyan})
call s:h("rubyRegexpDelimiter", { "fg": s:cyan})
call s:h("rubyStringDelimiter", { "fg": s:green})
call s:h("rubySymbol", { "fg": s:cyan})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:red })
call s:h("sassClass", { "fg": s:orange })
call s:h("sassControl", { "fg": s:pink })
call s:h("sassExtend", { "fg": s:pink })
call s:h("sassFor", { "fg": s:white })
call s:h("sassFunction", { "fg": s:cyan })
call s:h("sassId", { "fg": s:blue })
call s:h("sassInclude", { "fg": s:pink })
call s:h("sassMedia", { "fg": s:pink })
call s:h("sassMediaOperators", { "fg": s:white })
call s:h("sassMixin", { "fg": s:pink })
call s:h("sassMixinName", { "fg": s:blue })
call s:h("sassMixing", { "fg": s:pink })
call s:h("sassVariable", { "fg": s:pink })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:pink })
call s:h("scssImport", { "fg": s:pink })
call s:h("scssInclude", { "fg": s:pink })
call s:h("scssMixin", { "fg": s:pink })
call s:h("scssSelectorName", { "fg": s:orange })
call s:h("scssVariable", { "fg": s:pink })

" TypeScript
call s:h("typescriptReserved", { "fg": s:pink })
call s:h("typescriptEndColons", { "fg": s:white })
call s:h("typescriptBraces", { "fg": s:white })

" XML
call s:h("xmlAttrib", { "fg": s:orange })
call s:h("xmlEndTag", { "fg": s:red })
call s:h("xmlTag", { "fg": s:red })
call s:h("xmlTagName", { "fg": s:red })

" Elixir
call s:h("elixirAlias", { "fg": s:orange })
call s:h("elixirModuleDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirModuleDeclaration", { "fg": s:orange })
call s:h("elixirBlockDefinition", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirStructDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirPrivateDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirProtocolDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirExUnitMacro", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirImplDefine", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
call s:h("elixirAnonymousFunction", { "fg": s:pink })
call s:h("elixirDocString", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" })
call s:h("elixirDocTest", { "fg": s:comment_grey })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:orange, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:comment_grey })

" mhinz/vim-signify
call s:h("SignifySignAdd", { "fg": s:green })
call s:h("SignifySignChange", { "fg": s:yellow })
call s:h("SignifySignDelete", { "fg": s:red })

" neomake/neomake
call s:h("NeomakeWarningSign", { "fg": s:yellow })
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeInfoSign", { "fg": s:blue })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Rainbow Parentheses: {{{
if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#8dc8f3'], ['red', '#ff5370'],
      \ ['magenta', '#d666d6'], ['brown', '#fed631']
    \ ]
endif

let g:rainbow_guifgs = [ '#fed631', '#d666d6', '#8dc8f3', '#ff5370' ]
let g:rainbow_ctermfgs = [ 'brown', 'magenta', 'blue', 'red' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:pink })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}

" Neovim terminal colors {{{

if has("nvim")
  let g:terminal_color_0 =  s:black.gui
  let g:terminal_color_1 =  s:red.gui
  let g:terminal_color_2 =  s:green.gui
  let g:terminal_color_3 =  s:yellow.gui
  let g:terminal_color_4 =  s:blue.gui
  let g:terminal_color_5 =  s:pink.gui
  let g:terminal_color_6 =  s:cyan.gui
  let g:terminal_color_7 =  s:white.gui
  let g:terminal_color_8 =  s:visual_grey.gui
  let g:terminal_color_9 =  s:light_red.gui
  let g:terminal_color_10 = s:green.gui " No dark version
  let g:terminal_color_11 = s:orange.gui
  let g:terminal_color_12 = s:blue.gui " No dark version
  let g:terminal_color_13 = s:pink.gui " No dark version
  let g:terminal_color_14 = s:cyan.gui " No dark version
  let g:terminal_color_15 = s:comment_grey.gui
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
endif

" }}}

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
