# escape with ",." or ".,"
# Since either order works, you can press them
# "simultaneously" as a chord!
hook global InsertChar \. %{ try %{
  exec -draft hH <a-k>,\.<ret> d
  exec -with-hooks <esc>
}}
hook global InsertChar , %{ try %{
  exec -draft hH <a-k>\.,<ret> d
  exec -with-hooks <esc>
}}

# From https://kakoune-editor.github.io/community-articles/2021/01/01/first_two_hours_in_two_minutes.html

## Width of a tab
set-option global tabstop 4
set-option global indentwidth 4

## Softwrap long lines
add-highlighter global/ wrap -word -indent

## Clipboard
map -docstring "yank the selection into the clipboard" global user c "<a-|> xsel -i<ret>"
map -docstring "paste from the clipboard" global user v "<a-!> xsel<ret>"

## Shortcut to quickly exit the editor
define-command -docstring "save and quit" x "write-all; quit"

# From discuss.kakoune.com/u/Scriwtapello

## Change the cursor color depending on the mode

hook global ModeChange .*:insert %{
    set-face window PrimaryCursor black,rgb:11dd00
    set-face window PrimaryCursorEol default,rgb:33ee00
    set-face window PrimarySelection default,rgb:084400
    set-face window SecondaryCursor black,rgb:22bb08
    set-face window SecondaryCursorEol default,rgb:22dd08
    set-face window SecondarySelection default,rgb:113300
}

hook global ModeChange insert:.* %{
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
    unset-face window PrimarySelection
    unset-face window SecondaryCursor
    unset-face window SecondaryCursorEol
    unset-face window SecondarySelection
}

# My mapping, for Colemak-DHm

#  `                                     (-) (=) <=
# [*]  q   w  [e   b] (f) [j*][u] [i   a*]  ;   \
#        a*  r   s   t   g  [h   j   k   l]  o    '*
#          x   c [d/y* p]  z [k*](m)  ,   .   /
#                      [____________]

#   q    unchanged
#  [u]   overwrites the Colemak letter
# [...]  related adjacent overwritten keys are grouped together.
#  (f)   free for future use. (f) and (m) are there just in case
#        they're useful but might be changed later.
#   *    irregular change

# ` unchanged
# _ unchanged, - free
map global normal = ": comment-line<ret>"
# + free
map global normal <backspace> <a-d>
map global insert <a-backspace> "<a-;>b<a-;><a-d>"

map global insert <tab> <c-n>
map global insert <s-tab> <c-p>
map global normal <tab> n
map global normal <a-tab> <a-n>
map global normal <s-tab> N
map global normal <s-a-tab> <a-N>

# q unchanged
# w unchanged
map global normal f e # word nav.
map global normal F E # yes this is backwards, but it
map global normal p b # puts e in the location of qwerty e
map global normal P B
map global normal <a-f> <a-e>
map global normal <a-F> <a-E>
map global normal <a-p> <a-b>
map global normal <a-P> <a-B>
# b free but put f here for now
map global normal b f
map global normal B F
map global normal <a-b> <a-f> 
map global normal <a-B> <a-F>
map global normal j <a-j>
map global normal J <a-J>
map global normal l u # same location as qwerty u
map global normal L U
map global normal u i # same location as qwerty i
map global normal U I
map global normal y a # to the right of i
map global normal Y A
# ; unchanged
# [] unchanged
# {} unchanged
# \ unchanged

map global normal a <a-i>
map global normal A <a-a>
# r unchanged
# s unchanged
# t unchanged
# g unchanged
map global normal m h
map global normal M H
map global normal n j
map global normal N J
map global normal e k
map global normal E K
map global normal i l
map global normal I L
# o unchanged
map global normal <'> "<a-;>"

# x unchanged
# c unchanged
# d (lowercase) unchanged
map global normal D y
map global normal v p
map global normal V P
map global normal <a-v> v
map global normal <s-a-v> <c-v>
# z unchanged 
map global normal k <a-k>
map global normal K <a-K>
# h free but put m here for now
map global normal h m
map global normal H M
# , unchanged
# . unchanged
# / unchanged
# <space> unchanged

# home unchanged

# Move selection up or down 1 line
# Uses registers b and m.
map global normal <pageup> '<a-x>"mZ<a-:><a-;>k<a-x>"bd"mz"bp"mz'
#   <a-x>"mZ   select full lines and store the selection in register m.
#   <a-:><a-;> make sure the cursor is at the beginning
#   k<a-x>     select the line above the original selection
#   "bd        and store it in register b
#   "mz        restore the original selection
#   "bp        paste the line that was above, now below
#   "mz        restore the original selection again
map global normal <pagedown> '<a-x>"mZ<a-:>j<a-x>"bd"mz"bP"mz'
#   Same as above but taking the line below and putting it above.

# end unchanged
# delete free

# Prose

hook global BufCreate .+\.md %{ set buffer filetype md }
hook global BufSetOption filetype=md %{
    set-option buffer comment_line '//'
}
map global user h ": show-comment-headings<ret>"

# For each block of // comments, used for organizing writing
# and storing notes, extract the first line and show it with
# its line number. Set user-h to jump to that heading in the document.
define-command show-comment-headings %{
    # registers:
    # n = name of original buffer to go back to
    # b = contents of scratch buffer (comment headings)
    # l = line to go to in the original buffer
    set-register n "%val{bufname}"
    set-register b %sh{
       # Prepend line numbers. Keep only the first of adjacent comment lines.
       # Filter to keep only comment lines.
       eval "cat -n $kak_buffile | uniq --skip-chars=7 --check-chars=2 | egrep '^\s*[0-9]*\s//' 2>&1"
    }
    edit -scratch *comment-headings*
    exec '%<a-d>"bPgg'
    map buffer user h "H\;e<a-i>n""ly:<space>buffer<space><c-r>n<ret>:<space>exec<space><c-r>lg<ret>"
    # H\;       Go to the beginning of the line with no selection.
    # e<a-i>n   Select the line number.
    # "ly       Save the line number in register l.
    # : buffer  Go to a buffer...
    # <c-r>n<ret>                the original buffer.
    # : exec #g Go to line #, using <c-r>l to fill in the line number.
}

