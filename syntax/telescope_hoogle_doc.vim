" Hoogle doc contains some HTML tags. These have to be concealed and the text
" in between needs to be highlighted.

syn region codeBlock matchgroup=Tag start="<pre>" end="</pre>" concealends contains=TOP
syn region anchor matchgroup=Tag start="<a>" end="</a>" concealends contains=TOP
syn region teletype matchgroup=Tag start="<tt>" end="</tt>" concealends contains=TOP
syn region idiomatic matchgroup=Tag start="<i>" end="</i>" concealends contains=TOP
syn region listItem matchgroup=Tag start="<li>" end="</li>" concealends contains=TOP
syn region unorderedList matchgroup=Tag start="<ul>" end="</ul>" concealends contains=TOP
syn region orderedList matchgroup=Tag start="<ol>" end="</ol>" concealends contains=TOP

highlight def link codeBlock SpecialComment
highlight def link teletype Statement
highlight def link anchor Identifier
highlight def link idiomatic Structure
