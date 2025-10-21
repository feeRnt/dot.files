"$HOME/.vimrc
"(neo)-Vim configuration file

":scriptnames will show you all bootup config script s in vim

"inoremap jj <Esc>
" is a comment line in vim
" imap <S-Space> <Esc> ... doesn't work
" imap <M-Space> <Esc> this should work for linux but does cause a little popup on gnome ubuntu

"I. Map function 3 to print current time
nmap <F3> <C-R>=strftime("%B %d, %Y, %X")<CR>
imap <F3> <C-R>=strftime("%B %d, %Y, %X")<CR>


"II. Exit insert mode easily
inoremap jlkjlk <Esc>
imap adsads <Esc>
"new: oct 11
inoremap adss <Esc>
"new: Mar 15, '25
imap xzz <Esc>

"imap means in only input mode, inoremap is both input with.......? map

"III. Auto wraps , justify, newlines, according to dimension, width, and line breaks; Sep 22, 2024

set textwidth=0
set wrapmargin=1
set formatoptions+=t
set formatoptions-=l

"t auto wraps text, removing l allows modifying existent lines
"wrapmargin is number from right side of border where it is wrapped. text
"width is from left side of margin
"

"Don't auto wrap or create new lines, unless there is a space, enter, or other empty character nearby, May 30, 2025
"set formatoptions+=b
"set formatoptions+=v
"also check +v, which this is based on (Vi-compatible auto wrap)

"Sep 30

"IV. Left, Right for going up and down lines

set whichwrap+=<,>
"allow left, right arrow to go up or down lines in normal and visual modes

set whichwrap+=[,]
"allow left, right arrow to go up or down lines in Insert and Replace modes

set whichwrap+=h,l
"allow <h>, <l> keys to go up or down lines in Normal and Visual mode (You don't need it in insert mode because.. well.. you're gonna want to insert the literal h and l chars


"V. Show line numbers on the side of the screen
set number

"VI. Remap yank, delete and paste's clipboard to system (X11) clipboard by default

noremap <Leader>Y "*y
noremap <Leader>P "*p

noremap <Leader>y "+y
noremap <Leader>p "+p

"Leader key is \ by default

"seems like in my system + and * are the same/shared so the last 2 are not
"needed?
"nvm. for some reason i can't access * clipboard (primary.)
"even in normal desktop use. switched + to lowercase

"Oct 17
"noremap <Leader>D "*d
noremap <Leader>d "+d


"October 11, 2024

"VII. Delete word backward and forward

inoremap <C-e> <C-o>dw
"Insert mode only . Ctrl e to delete backward , ctrl b to delete forward
"<C-o> puts you in insert mode after executing the following command

"inoremap <C-H> <C-o>db 
"(this kinda sucks (keeps letters sometimes, replacing with native solution)

"inoremap <C-H> <C-o><C-W>
"native solution doesn't work. Going back to original broken implementation
"for now. just figure out what C-W is mapped to in nvim and youre good

inoremap <C-H> <C-w>
"this is the real native solution lol 


"inoremap <C-H> <C-o>db<C-o>h 
"improved

inoremap <M-BS> <C-o>dw
"insert mode only. Ctrl backspace to delete backward, Alt Backspace to delete forward

"<C-H> is equivalent to Ctrl-Backspace.
"Test using Ctrl+V in input mode then press Desired key/combination to find its terminal
"equivalent" (the things you see when you press buttons in terminal with
"another process running stdout at the same time.)

"nnoremap <C-H> <C-o>db
"nnoremap <M-S> <C-o>dw
"normal mode only. don't want to enter insert mode while deleting like this.
"or do I? maybe I . Okay I do
"

"VIII. Make alt-left,right move like ctrl-left,right in normal mode like standard Gedit

"nnoremap <M-<Left>> b
"<M-Left> "acquired from pressing ctrl+v then alt+left arrow in insert mode

nnoremap <M-Left> b
nnoremap <M-Right> e
"this follows normal ctrl <,> behavior of most text software things


"IX. no case sensitivity in searches, do :set noic to turn sensitivity back on 
set ic

"X. Make undo sensible, Oct 19, 2024

" create undo points when 
" typing these keys -- u/catorchid  (<C-g>u sets a new undo point in insert mode)
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ( (<c-g>u
inoremap [ [<c-g>u
inoremap = =<c-g>u
inoremap \" \"<c-g>u
inoremap <space> <space><c-g>u
inoremap <CR> <CR><c-g>u
"more
inoremap <BS> <BS><C-g>u
"inoremap <C-H> is addressed in the relevant section (ctrl - BS, VII.)


"XI. Make system clipboard paste (ctrl+shift+v) add newlines in vim document
"when necessary, Oct 23, 2024

"inoremap <C-S-V> <C-S-V><C-o>gql
"gql makes the lines justified in normal mode.

" ^^^^ This does not work (same for C-S-V), see [@5]

"XII. Change default colorscheme. 
"TODO: read the current bash profile (day, night, custom name) and change
"scheme based on that
colorscheme desert

"XIII. Make cursor visible and nice in all modes: Jul 23, 2025
"set guicursor=n-v-c:block,i:blinkon1-blinkoff1-fat

"XIII. Make cursor visible and nice in insert modes: Jul 23, 2025
"set guicursor=i:blinkon1-blinkoff1
"set guicursor=n-v-c:block,i:blinkon1-blinkoff1
set guicursor=i:ver50-blinkon1-blinkoff1


"=-=--=-=-=- Useful keys
"
"1. Create new line without insert mode
"
"Hit o<Esc> really fast and blink at the same time. You can repeat with . with your eyes open.
"
"-- This is the power of the reddit bro


"2. Repeat last motion/
"
"Hit <.>
"

" --- Oct 1

" 3. Clipboard registers * and + not working::
"
"Your vim version may not be compiled with X11 clipboard .
"
"In vim run the :version command and look for xterm_clipboard in the output. It will be prefixed with a + (supported) or - (unsupported) sign.
"--blankblank
"
"vim in fedora does not come with x11 support. install vim-X11 and use
"gvim -v (-v = terminal) or vimx

" --- Oct 11
"
"  
" 4. Moving to start and end of line :
 
"Just the $ (dollar sign) key. You can use A to move to the end of the line and switch to editing mode (Append). To jump to the last non-blank character, you can press g then _ keys.

"The opposite of A is I (Insert mode at beginning of line), as an aside. Pressing just the ^ will place your cursor at the first non-white-space character of the line



"5. Linebreaks in paragraph and pasted text, gql
"https://www.reddit.com/r/vim/comments/q3ob4c/vim_pasting_from_into_editor_pastes_all_text_into/ , Oct 18
"

 
" This is how most other text editors to it too (e.g. ms word), but they
" process movement differently. Vim just keeps treating this as a single line
" when you move up/down with j and k. If you want to actually insert new
" linebreak characters in the text, use gql as others have suggested.
" 
" However, if you're used to ms word style editors and want to mimic the
" behaviour, then using gj and gk instead of j and k will move your cursor
" more 'intuitively'.
" 
" nnoremap j gj 
" nnoremap k gk
" 
" You probably also want to rebind stuff like 0 and $ so you can go home/end
" intuitively
" 
" nnoremap 0 g0
" nnoremap $ g$
" 
" You can also make vim wrap on words, rather than just characters, which is how ms word does it:
" 
" :set wrap lbr
" 
" These configurations might make vim a little easier for you, rather than just brute forcing it & changing the text with gq

"6. Add comments to a set of lines:
"
" a. Enter visual mode (ctrl+v in normal mode)
" b. Press down to select the desired text.
" c. Press capital I to enter insert mode, then press the comment keyword of choice (")
" d. Press Esc

"6.5. Delete comment block that is on a set of lines:
" a. Follow 6(a,b)
" b. Hit lower case d

"7. Load a particular vimrc , for example when using sudo vim file
"
"vim -u /path/to/your/.vimrc

"For sudo, you can do

"sudo ln -s ~/.config/nvim/init.vim /usr/share/nvim/sysinit.vim
"PopOS/Ubuntu. You can $VIM/sysinit.vim, but its empty for me by default. 
"/usr/share/nvim/runtime/sysinit.vim strangely doesn't work with this.


"8. Jump to the start or close of brackets: Nov 24
" press % in visual mode to jump to other parenthesis pair.

"9. Search and replace: February '25
" :%s/old_pattern/new_pattern/gc
" or
" :s/old_pattern/new_pattern/gc (only in the current line). 
" g is the global flag , c is the confirmation flag
"

"10. Save a file with a new name, retaining the original with the original name: May '25
":sav {newfilename}
"or 
":saveas {newfilename}

"11. Create and switch to different windows, Jul '25
":vertical filename (this doesn't work)
":vsplit
"OR
":horizontal filename (this doesn't work)
":hsplit
"
":split

"Then press "Ctrl+w"+<direction_of_window> , to switch to it
"OR
"<sl. number of window>+"Ctrl+w"+"Ctrl+w"
"OR
""ctrl+w"+"ctrl+w" to switch to the last used window

"References------
"1. 

"Due to the way that the keyboard input is handled internally, this
"unfortunately isn't generally possible today, even in GVIM. Some key
"combinations, like Ctrl + non-alphabetic cannot be mapped, and Ctrl + letter
"vs. Ctrl + Shift + letter cannot be distinguished. (Unless your terminal
"sends a distinct termcap code for it, which most don't.) In insert or
"command-line mode, try typing the key combination. If nothing happens / is
"inserted, you cannot use that key combination. This also applies to <Tab> /
"<C-I>, <CR> / <C-M> / <Esc> / <C-[> etc. (Only exception is <BS> / <C-H>.)
"This is a known pain point, and the subject of various discussions on vim_dev
"and the #vim IRC channel.
"
"Some people (foremost Paul LeoNerd Evans) want to fix that (even for console
"Vim in terminals that support this), and have floated various proposals, cp.
"http://groups.google.com/group/vim_dev/browse_thread/thread/626e83fa4588b32a/bfbcb22f37a8a1f8
"
"But as of today, no patches or volunteers have yet come forward, though many
"have expressed a desire to have this in a future Vim 8 major release.
"
"
"
"
"nov 13 
"
"org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:80a974ee-9729-4c64-9278-e970a961453e/ use-theme-colors false
"
"read: profile. if  day mode profile = active . then in vim, use sepcificc profile.
