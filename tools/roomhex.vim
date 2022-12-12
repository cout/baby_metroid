syn match slope "\<1[0-9A-F][0-9A-F][0-9A-F]\>"
syn match spikeair "\<2[0-9A-F][0-9A-F][0-9A-F]\>"
syn match specialair "\<3[0-9A-F][0-9A-F][0-9A-F]\>"
syn match shootableair "\<4[0-9A-F][0-9A-F][0-9A-F]\>"
syn match horizextension "\<5[0-9A-F][0-9A-F][0-9A-F]\>"
syn match bombableair "\<7[0-9A-F][0-9A-F][0-9A-F]\>"
syn match bombableair "\<7[0-9A-F][0-9A-F][0-9A-F]\>"
syn match solidblock "\<8[0-9A-F][0-9A-F][0-9A-F]\>"
syn match doorblock "\<9[0-9A-F][0-9A-F][0-9A-F]\>"
syn match spikeblock "\<A[0-9A-F][0-9A-F][0-9A-F]\>"
syn match specialblock "\<B[0-9A-F][0-9A-F][0-9A-F]\>"
syn match shootableblock "\<C[0-9A-F][0-9A-F][0-9A-F]\>"
syn match vertextension "\<D[0-9A-F][0-9A-F][0-9A-F]\>"
syn match grappleblock "\<E[0-9A-F][0-9A-F][0-9A-F]\>"
syn match bombableblock "\<F[0-9A-F][0-9A-F][0-9A-F]\>"
syn match emptyblock "\<00FF\>"

hi solidblock ctermbg=DarkGreen ctermfg=White
hi slope ctermbg=DarkCyan ctermfg=White
hi spikeair ctermfg=Red
hi specialair ctermfg=Blue
hi shootableair ctermfg=DarkYellow
" horizextension
hi bombableair ctermfg=Magenta
hi doorblock ctermbg=DarkCyan ctermfg=White
hi spikeblock ctermbg=DarkRed ctermfg=White
hi specialblock ctermbg=DarkBlue ctermfg=White
hi shootableblock ctermbg=DarkYellow ctermfg=White
" vertextension
hi grappleblock ctermbg=DarkGray ctermfg=White
hi bombableblock ctermbg=DarkMagenta ctermfg=White
hi emptyblock ctermfg=DarkGrey

syn match bts "\<[1-9A-F][0-9A-F]\>"
syn match bts "\<[0-9A-F][1-9A-F]\>"
syn match emptybts "\<00\>"

hi bts ctermfg=White
hi emptybts ctermfg=DarkGrey

syn match comment ";.*"
