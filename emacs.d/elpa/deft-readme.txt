Deft is an Emacs mode for quickly browsing, filtering, and editing
directories of plain text notes, inspired by Notational Velocity.
It was designed for increased productivity when writing and taking
notes by making it fast and simple to find the right file at the
right time and by automating many of the usual tasks such as
creating new files and saving files.

Deft is open source software and may be freely distributed and
modified under the BSD license.  Version 0.5.1 is the latest stable
version, released on January 28, 2013.  You may download it
directly here:

  * [deft.el](http://jblevins.org/projects/deft/deft.el)

To follow or contribute to Deft development, you can either
[browse](http://jblevins.org/git/deft.git) or clone the Git
repository:

    git clone git://jblevins.org/git/deft.git

![File Browser](http://jblevins.org/projects/deft/browser.png)

The Deft buffer is simply a file browser which lists the titles of
all text files in the Deft directory followed by short summaries
and last modified times.  The title is taken to be the first line
of the file and the summary is extracted from the text that
follows.  Files are, by default, sorted in terms of the last
modified date, from newest to oldest.

All Deft files or notes are simple plain text files where the first
line contains a title.  As an example, the following directory
structure generated the screenshot above.

    % ls ~/.deft
    about.txt    browser.txt     directory.txt   operations.txt
    ack.txt      completion.txt  extensions.txt  text-mode.txt
    binding.txt  creation.txt    filtering.txt

    % cat ~/.deft/about.txt
    About

    An Emacs mode for slicing and dicing plain text files.

![Filtering](http://jblevins.org/projects/deft/filter.png)

Deft's primary operation is searching and filtering.  The list of
files can be limited or filtered using a search string, which will
match both the title and the body text.  To initiate a filter,
simply start typing.  Filtering happens on the fly.  As you type,
the file browser is updated to include only files that match the
current string.

To open the first matching file, simply press `RET`.  If no files
match your search string, pressing `RET` will create a new file
using the string as the title.  This is a very fast way to start
writing new notes.  The filename will be generated automatically.
If you prefer to provide a specific filename, use `C-RET` instead.

To open files other than the first match, navigate up and down
using `C-p` and `C-n` and press `RET` on the file you want to open.
When opening a file, Deft searches forward and leaves the point
at the end of the first match of the filter string.

You can also press `C-o` to open a file in another window, without
switching to the other window.  Issue the same command with a prefix
argument, `C-u C-o`, to open the file in another window and switch
to that window.

To edit the filter string, press `DEL` (backspace) to remove the
last character or `M-DEL` to remove the last "word".  To yank
(paste) the most recently killed (cut or copied) text into the
filter string, press `C-y`.  Press `C-c C-c` to clear the filter
string and display all files and `C-c C-g` to refresh the file
browser using the current filter string.

For more advanced editing operations, you can also edit the filter
string in the minibuffer by pressing `C-c C-l`.  While in the
minibuffer, the history of previous edits can be cycled through by
pressing `M-p` and `M-n`.  This form of static, one-time filtering
(as opposed to incremental, on-the-fly filtering) may be preferable
in some situations, such as over slow connections or on systems
where interactive filtering performance is poor.

By default, Deft filters files in incremental string search mode,
where "search string" will match all files containing both "search"
and "string" in any order.  Alternatively, Deft supports direct
regexp filtering, where the filter string is interpreted as a
formal regular expression.  For example, `^\(foo\|bar\)` matches
foo or bar at the beginning of a line.  Pressing `C-c C-t` will
toggle between incremental and regexp search modes.  Regexp
search mode is indicated by an "R" in the mode line.

Deft, by default, lists files from newest to oldest.  You can set
`deft-current-sort-method' to 'title to sort by file titles, case
ignored.  Or, you can toggle sorting method using
`deft-toggle-sort-method'.

Common file operations can also be carried out from within Deft.
Files can be renamed using `C-c C-r` or deleted using `C-c C-d`.
New files can also be created using `C-c C-n` for quick creation or
`C-c C-m` for a filename prompt.  You can leave Deft at any time
with `C-c C-q`.

Archiving unused files can be carried out by pressing `C-c C-a`.
Files will be moved to `deft-archive-directory', which is a
directory named `archive` within your `deft-directory' by default.

Files opened with deft are automatically saved after Emacs has been
idle for a customizable number of seconds.  This value is a floating
point number given by `deft-auto-save-interval' (default: 1.0).

Getting Started
---------------

To start using it, place it somewhere in your Emacs load-path and
add the line

    (require 'deft)

in your `.emacs` file.  Then run `M-x deft` to start.  It is useful
to create a global keybinding for the `deft` function (e.g., a
function key) to start it quickly (see below for details).

When you first run Deft, it will complain that it cannot find the
`~/.deft` directory.  You can either create a symbolic link to
another directory where you keep your notes or run `M-x deft-setup`
to create the `~/.deft` directory automatically.

One useful way to use Deft is to keep a directory of notes in a
Dropbox folder.  This can be used with other applications and
mobile devices, for example, Notational Velocity or Simplenote
on OS X, Elements on iOS, or Epistle on Android.

Customization
-------------

Customize the `deft` group to change the functionality.

By default, Deft looks for notes by searching for files with the
extension `.txt` in the `~/.deft` directory.  You can customize
both the file extension and the Deft directory by running
`M-x customize-group` and typing `deft`.  Alternatively, you can
configure them in your `.emacs` file:

    (setq deft-extension "txt")
    (setq deft-directory "~/Dropbox/notes")

You can also customize the major mode that Deft uses to edit files,
either through `M-x customize-group` or by adding something like
the following to your `.emacs` file:

    (setq deft-text-mode 'markdown-mode)

Note that the mode need not be a traditional text mode.  If you
prefer to write notes as LaTeX fragments, for example, you could
set `deft-extension' to "tex" and `deft-text-mode' to `latex-mode'.

If you prefer `org-mode', then simply use

    (setq deft-extension "org")
    (setq deft-text-mode 'org-mode)

For compatibility with other applications which take the title from
the filename, rather than from first line of the file, set the
`deft-use-filename-as-title' flag to a non-nil value.  This also
changes the default behavior for creating new files when the filter
is non-empty: the filter string will be used as the new filename
rather than inserted into the new file.  To enable this
functionality, simply add the following to your `.emacs` file:

    (setq deft-use-filename-as-title t)

You can easily set up a global keyboard binding for Deft.  For
example, to bind it to F8, add the following code to your `.emacs`
file:

    (global-set-key [f8] 'deft)

Deft also provides a function for opening files without using the
Deft buffer directly.  Calling `deft-find-file' will prompt for a
file to open, just like `find-file', but starting from
`deft-directory'.  If the file selected is in `deft-directory', it
is opened with the usual deft features (using `deft-text-mode',
automatic saving, automatic updating of the Deft buffer, etc.).
Otherwise, the file will be opened by `find-file' as usual.
Therefore, you can set up a global keybinding for this function to
open Deft files anywhere.  For example, to use `C-x C-g`, a
neighbor of `C-x C-f`, use the following:

    (global-set-key (kbd "C-x C-g") 'deft-find-file)

The faces used for highlighting various parts of the screen can
also be customized.  By default, these faces inherit their
properties from the standard font-lock faces defined by your current
color theme.

Incremental string search is the default method of filtering on
startup, but you can set `deft-incremental-search' to nil to make
regexp search the default.

The title of each file is taken to be the first line of the file,
with certain characters removed from the beginning (hash
characters, as used in Markdown headers, and asterisks, as in Org
Mode headers).  The substrings to remove are specified in
`deft-strip-title-regexp'.

More generally, the title post-processing function itself can be
customized by setting `deft-parse-title-function', which accepts
the first line of the file as an argument and returns the parsed
title to display in the file browser.  The default function is
`deft-strip-title', which removes all occurrences of
`deft-strip-title-regexp' as described above.

Acknowledgments
---------------

Thanks to Konstantinos Efstathiou for writing simplnote.el, from
which I borrowed liberally, and to Zachary Schneirov for writing
Notational Velocity, whose functionality and spirit I wanted to
bring to Emacs.

History
-------

Version 0.5.1 (2013-01-28):

* Bug fix: creating files with `C-c C-n` when both the filter string and
  `deft-use-filename-as-title' are non-nil resulted in an invalid path.
* Bug fix: killed buffers would persist in `deft-auto-save-buffers'.

Version 0.5 (2013-01-25):

* Implement incremental string search (default) and regex search.
  These search modes can be toggled by pressing `C-c C-t`.
* Default search method can be changed by setting `deft-incremental-search'.
* Support custom `deft-parse-title-function' for post-processing titles.
* The default `deft-parse-title-function' simply strips occurrences of
  `deft-strip-title-regexp', which removes Markdown and Org headings.
* Open files in another window with `C-o`.  Prefix it with `C-u` to
  switch to the other window.
* For symbolic links, use modification time of taget for sorting.
* When opening files, move point to the end of the first match of
  the filter string.
* Improved filter editing: delete (`DEL`), delete word (`M-DEL`),
  and yank (`C-y`).
* Advanced filter editing in minibuffer (`C-c C-l`).

Version 0.4 (2011-12-11):

* Improved filtering performance.
* Optionally take title from filename instead of first line of the
  contents (see `deft-use-filename-as-title').
* Dynamically resize width to fit the entire window.
* Customizable time format (see `deft-time-format').
* Handle `deft-directory' properly with or without a trailing slash.

Version 0.3 (2011-09-11):

* Internationalization: support filtering with multibyte characters.

Version 0.2 (2011-08-22):

* Match filenames when filtering.
* Automatically save opened files (optional).
* Address some byte-compilation warnings.

Deft was originally written by [Jason Blevins](http://jblevins.org/).
The initial version, 0.1, was released on August 6, 2011.
