" project source for unite.vim
" Version:     0.1.0
" Author:      Alex Cornejo
" Licence:     The MIT License {{{
"     Permission is hereby granted, free of charge, to any person obtaining a copy
"     of this software and associated documentation files (the "Software"), to deal
"     in the Software without restriction, including without limitation the rights
"     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"     copies of the Software, and to permit persons to whom the Software is
"     furnished to do so, subject to the following conditions:
"
"     The above copyright notice and this permission notice shall be included in
"     all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
"     THE SOFTWARE.
" }}}

let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'projects',
      \ 'hooks': {},
      \ 'default_action': {'cdable': 'rec/async'},
      \ }

let g:unite_project_list_command =
    \ get(g:, 'unite_project_list_command', 'find ~/devel -type d -name .git -maxdepth 3 | sed -e "s#/.git##g"')

function! s:unite_source.gather_candidates(args, context)
  let dirlist = split(system(g:unite_project_list_command),'\n')

  return map(dirlist, '{
        \ "word": v:val,
        \ "source": "projects",
        \ "kind": "cdable",
        \ "action__path": v:val,
        \ }')
endfunction

function! unite#sources#projects#define()
  return s:unite_source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
