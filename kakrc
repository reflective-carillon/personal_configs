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
#        a*  r   s   t   g  [h   j   k   l]  o    '
#          x   c [d/y* p]  z [k*](m)  ,   .   /
#                      [____________]

#   q    unchanged
#  [u]   overwrites the Colemak letter
# [...]  related adjacent overwritten keys are grouped together.
#  (f)   free for future use. (f) and (m) are there just in case
#        they're useful but might be changed later.
#   *    iregular change

# ` unchanged
map global normal <tab> <c-n>
map global normal <s-tab> <c-p>

# q unchanged
# w unchanged
map global normal f e # word nav.
map global normal F E # yes this is backwards, but it
map global normal p b # puts e in the location of qwerty e
map global normal P B
# b free but put f here for now
map global normal b f
map global normal B F
map global normal j <a-j>
map global normal J <a-J>
map global normal l u # same location as qwerty u
map global normal L U
map global normal u i # same location as qwerty i
map global normal U I
map global normal y a # to the right of i
map global normal Y A
# ; unchanged
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
# ' unchanged

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
map global normal <'> "<a-;>"
# {} unchanged
# [] unchanged
map global normal <backspace> <a-d>
map global insert <c-backspace> "<a-;>b<a-;><a-d>"
# map global insert <c-backspace> doesn't work. TODO

# home unchanged
map global normal <pageup> "<a-x>dk<home>Pk<end>" # move selection up 1 line
map global normal <pagedown> "<a-x>djPk<end>"     # move selection down 1 line
# end unchanged
# delete free





