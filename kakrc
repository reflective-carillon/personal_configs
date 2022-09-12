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
# Also allow this to work in normal mode.
map global user , <esc>
map global user . <esc>
map global user / . # keep a way to repeat
# vz/zv
hook global InsertChar v %{ try %{
  exec -draft hH <a-k>zv<ret> d
  exec -with-hooks <esc>
}}
hook global InsertChar z %{ try %{
  exec -draft hH <a-k>vz<ret> d
  exec -with-hooks <esc>
}}
# xv/vx
hook global InsertChar v %{ try %{
  exec -draft hH <a-k>xv<ret> d
  exec -with-hooks <esc>
}}
hook global InsertChar x %{ try %{
  exec -draft hH <a-k>vx<ret> d
  exec -with-hooks <esc>
}}
# xz/zx
hook global InsertChar x %{ try %{
  exec -draft hH <a-k>zx<ret> d
  exec -with-hooks <esc>
}}
hook global InsertChar z %{ try %{
  exec -draft hH <a-k>xz<ret> d
  exec -with-hooks <esc>
}}

# From https://kakoune-editor.github.io/community-articles/2021/01/01/first_two_hours_in_two_minutes.html

## Width of a tab
set-option global tabstop 4
set-option global indentwidth 4

## Softwrap long lines
add-highlighter global/ wrap -word -indent

## Clipboard
map -docstring "yank the selection into the clipboard" global user c "<a-|> xsel --clipboard -i<ret>"
map -docstring "paste from the clipboard" global user v "<a-!> xsel --clipboard<ret>"

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

# from https://github.com/mawww/config/blob/master/kakrc
define-command find -menu -params 1 -shell-script-candidates %{ ag -g '' --ignore "$kak_opt_ignored_files" } %{ edit %arg{1} }

define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }

# My mapping, for Colemak-DHm

#  `                                     (-) (=*) <=*
# [*]  q   w   e  [t]  b  [j*][u] [i   a*]  ;   \
#        a*  r   s   t   g  [h   j   k   l]  o    '*
#          x*  c  d/y*[p]  z [k*](m)  ,   .   /
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
map global normal <a-backspace> "b<a-d>"
map global insert <a-backspace> "<a-;>b<a-;><a-d>"

# from https://github.com/mawww/config/blob/master/kakrc
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

map global normal <tab> n
map global normal <a-tab> <a-n>
map global normal <s-tab> N
map global normal <s-a-tab> <a-N>

# q unchanged
# w unchanged
map global normal f e # word nav.
map global normal F E # yes this is backwards, but it
                      # puts e in the location of qwerty e
map global normal p <a-t> # see note below on p and t
map global normal P <a-T>
map global normal <a-p> <a-f>
map global normal <a-P> <a-F>
map global normal <c-p> <c-u>
map global normal <a-f> <a-e>
map global normal <a-F> <a-E>
# b unchanged
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
map global normal t t # see note below on p and t
map global normal T T
map global normal <a-t> f
map global normal <a-T> F
map global normal <c-t> <c-d>
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

map global normal x <a-x> # swap alt and non-alt functions of x
map global normal X <a-X>
map global normal <a-x> x
map global normal <a-X> X
# c free, C unchanged
# d (lowercase) unchanged
map global normal D y
map global normal v p
map global normal V P
map global user -docstring 'view mode' v v
map global user -docstring 'lock view mode' V V
map global normal <a-v> <a-p>
map global normal <a-V> <a-P>
# z unchanged 
map global normal k <a-k>
map global normal K <a-K>
# h free but put m here for now
map global normal h m
map global normal H M
# , unchanged
map global normal . ,
# / unchanged
# <space> unchanged

# home unchanged
# end unchanged

# Note on p and t:
# These keys, which are vertically adjacent on Colemak, form a pair.
# p/t selects to a character backwards or forwards. P/T extends.
# Alt p/t selects to a character, including that character. Alt P/T extends.
# Ctrl p/t scrolls by half pages.

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

# delete free

# Math

map global user -docstring 'evaluate math and append result after " = "' m '_"by|bc<ret><a-:>"mZi<space>=<space><esc>hhh"bP"mzl'
# register b holds the text of selection
# register m holds the selection position
# _         trim the selection
# "by       store it in register b
# |bc<ret>  do the math with the `bc` command on the shell, overwriting the selection
# <a-:>"mZ  store the position of the result, selected with the cursor on the right
# i<space>=<space><esc>    prepend " = "
# hhh       move to before the " = "
# "bP       paste the original math expression
# "mzl      select the result again and move to just after the result

# Prose

hook global BufCreate .+\.md %{ set buffer filetype md }
hook global BufSetOption filetype=md %{
    set-option buffer comment_line '//'
    hook buffer BufWritePost .* %{
        nop %sh{
            npx prettier --prose-wrap always --write "$kak_buffile" &
        }
    }
}
map global user -docstring 'show comment headings; repeat command to return to chosen heading' h ": show-comment-headings<ret>"

# For each block of comments, extract the first line and show it with
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
       # Comment lines are assumed to have 2 chars in common, since comment
       # line strings are usually either 2 chars ("//", "--") or 1 char ("#").
       # If the comment string is 1 char, comparing on 2 chars should still be
       # safe since it's good style to put a space before the text of the comment.
       eval 'cat -n $kak_buffile | uniq --skip-chars=7 --check-chars=2 | egrep "^\s*[0-9]*\s$kak_opt_comment_line" 2>&1'
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
    map buffer user q ": buffer<c-r>n<ret>" # go back to the original buffer
}

# Word Count
# Uses the o buffer.
# Not intended for multiple selections. 
map global user -docstring 'wc' <#> '|wc<ret>"oyu: info ''<c-r>o''<ret>'
# |wc<ret>              replace the selection with the `wc` output
# "oy                   store the output in the o buffer
# u                     undo the pipe, restoring the original selection
# : info '<c-r>o'<ret>  display the `wc` output

# Convenient copy/paste shortcuts with non-default buffers.

map global user -docstring '"sd' s '"sd'
map global user -docstring '"sy' S '"sy'
map global user -docstring '"sp' t '"sp'
map global user -docstring '"sP' T '"sP'
map global user -docstring '"fd' f '"fd'
map global user -docstring '"fy' F '"fy'
map global user -docstring '"fp' p '"fp'
map global user -docstring '"fP' P '"fP'

# Code Formatting

hook global BufSetOption filetype=ocaml %{
   map buffer user -docstring "format file (ocamlformat)" r '"mZ%%|ocamlformat - --enable-outside-detected-project --name "$kak_buffile" || echo "error, check *debug*"<ret>"mz'
}

