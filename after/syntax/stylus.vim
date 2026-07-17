" Stylus syntax groups are defined but never linked.
" See $VIMRUNTIME/syntax/stylus.vim - it relies on css.vim for css* groups
" but leaves stylus* groups unlinked, so they render with no color.

" Comments
hi def link stylusComment Comment

" Variables and identifiers
hi def link stylusVariable Identifier
hi def link stylusVariableAssignment Identifier

" CSS-like properties -> follow cssProp convention
hi def link stylusProperty cssProp
hi def link stylusCssAttribute None

" Functions
hi def link stylusFunction Function
hi def link stylusUserFunction Function

" Control flow keywords (if/else/for/unless/return)
hi def link stylusControl Statement

" Imports
hi def link stylusImport PreProc
hi def link stylusImportList None

" Selectors
hi def link stylusAmpersand Special
hi def link stylusClassChar Special
hi def link stylusClass Type
hi def link stylusIdChar Special
hi def link stylusId Type

" Misc
hi def link stylusInterpolation Special
hi def link stylusEscape Special
