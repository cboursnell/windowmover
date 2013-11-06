windowmover
===========

Position windows on a screen

## Usage

```
$ windowmover --help
v0.0.1a
Options:
        --left, -l:   Move active window to the left
       --right, -r:   Move active window to the left
  --fullheight, -f:   Increase height to full
        --test, -t:   Don't actually do anything
     --version, -v:   Print version and exit
        --help, -h:   Show this message

```

e.g.: `windowmover --left` will move the active window to the left

## Requirements

`wmctrl` needs to be installed. This can be done on Debian-based systems with:

`apt-get install wmctrl`

and on Fedora with:

`yum install wmctrl`