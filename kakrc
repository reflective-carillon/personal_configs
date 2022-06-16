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

## Change the background color depending on the mode

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

#  `                                (-) (=) <=
#  q  [z] [w   e] (b)<a-j>[u] [i   a]  ;   \
#   [a*](r)  s   t   g  [h   j   k   l]<a-;>[x]
#     [d   y   P   R*  p]<a-k>(h)  ,   .   /
#                  [____________]

#   q    unchanged
#  [z]   functions as z does by default
# [...]  related adjacent overwritten keys are grouped together.
#  (b)   free for future use
# <a-j>  functions as <a-j> does by default. J functions as <a-J> too.
#   *    irregular change.  a is <a-i>, A is <a-a>. <a-v> is v.

# q unchanged
map global normal w z
map global normal W Z

map global normal f b # word nav
map global normal F B
map global normal p e
map global normal P E
# b free
# ` unchanged
#
# j unchanged
map global normal l u # same location as qwerty u
map global normal L U
map global normal u i # same location as qwerty i
map global normal L I
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
map global insert <tab> <c-n>
map global insert <s-tab> <c-p>
#
map global normal m h
map global normal M H
map global normal n j
map global normal N J
map global normal e k
map global normal E K
map global normal i l
map global normal I L
map global normal o "<a-;>"
map global normal O "<a-:>"
map global normal <'> <a-x>

map global normal x d
map global insert <c-x> "<a-;>d"
map global normal c y
map global insert <c-c> "<a-;>y"
map global normal d P
map global insert <c-d> "<a-;>P"
map global normal v R
map global insert <c-v> "<a-;>R"
map global normal z p
map global insert <c-z> "<a-;>p"

map global normal <a-v> v
map global normal <s-a-v> <c-v>

# esc unchanged
# return unchanged
# k unchanged
# h free
# , unchanged
# . unchanged
# / unchanged
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





