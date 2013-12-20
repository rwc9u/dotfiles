# Robe [![Build Status](https://travis-ci.org/dgutov/robe.png?branch=master)](https://travis-ci.org/dgutov/robe)

This builds on `inf-ruby` to handle Ruby subprocesses from Emacs.
Generally, you'll want to use `M-x inf-ruby-console-auto`. If there's
no Ruby console running, `robe` will offer to call it automatically.

Once you have you application or gem loaded in the console, Ruby keeps
track of where each method is defined.

You can jump to or read the documentation for the method, module (jump only),
`super` or constructor definition at point.

If the method call target is implicit (like with `super`), or the call target is
obvious (`Foo.new`, `self.foo`), then we first try to look for the definition in
superclasses, descendants and included modules as appropriate.

If the result is ambiguous, you're prompted to pick the module/location.

ElDoc support and constant and method completion are also provided.

To see the available commands, type <kbd>M-x describe-package RET robe RET</kbd>.

## Install

Set up [Melpa](http://melpa.milkbox.net/#installing) if you haven't already,
then type <kbd>M-x package-install RET robe RET</kbd>.

In the init file:

```lisp
(add-hook 'ruby-mode-hook 'robe-mode)
```

## Dependencies

* `pry`
* `pry-doc` (on MRI)
* `method_source >= 0.8.2` (for compatibility with the latest Rubinius)

Note that if your project is using `Bundler`, the dependencies have to be added to the `Gemfile`.

## Completion

### [company-mode](http://company-mode.github.com/) ([screenshot](robe-company.png)):

```lisp
(push 'company-robe company-backends)
```

### [auto-complete](http://auto-complete.org/):

```lisp
(push 'ac-source-robe ac-sources)
```

Both of the above work only when the connection to the `inf-ruby` process has
been established. To do that, either use one of the core `robe` commands, or
type <kbd>M-x robe-start</kbd>.

Built-in completion (triggered with <kbd>C-M-i</kbd>) is also supported.

## Compatibility

* Tested in Emacs 24.3+, with Ruby 1.9.3 and 2.0.0, on GNU/Linux.
* Essential features work with JRuby and the latest Rubinius.
  JRuby has longer startup, Rubinius is noticeably slower at runtime
  ([rubinius/rubinius#2390](https://github.com/rubinius/rubinius/issues/2390)).
* Mostly works on MS Windows, with minor glitches.
* Using Emacs trunk is currently recommended (24.3.50) for better recognition
  of context at point.

## Notes

* We can't jump to methods defined in C (such as most of the core classes).
  To read their docs, install `pry-doc` or add it to your Gemfile.
* We can't jump to lazily defined methods, such as `model.column` or `find_by_`
  `ActiveRecord` methods, before they've been called. This is treatable, but low
  priority.
* Jumping to methods defined with `Module#delegate` just brings us to the place
  where `delegate` is called, which is accurate, but often less than useful.
* Having more than one `inf-ruby` buffer at a time is not supported. If you see
  unexpected "Method not found" errors, check if you have an older one.

## Todo

* Handle `delegate` and `send`, `Class.new.method` and `self.class.method`.
* For methods defined through macros, optionally jump to where the macro was
  called, instead of its definition?
* Apropos search for classes and methods.
* Type inference and local variable completion.

## Copying

Copyright © 2012 Phil Hagelberg

Copyright © 2012, 2013 Dmitry Gutov

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Emacs; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
Boston, MA 02110-1301, USA.

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/de7c96160d19b6945b432196a97eaaf3 "githalytics.com")](http://githalytics.com/dgutov/robe)
