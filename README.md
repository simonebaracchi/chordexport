# chordexport

This is a simple tool to import chords (or similarly formatted HTML?) and show them in the UNIX shell and/or make them more edit-friendly.

More precisely: it reformats HTML when text and other super-positioned text (`<sup>`) are used together, by splitting text and super-positioned stuff on two separate lines.

**Usage**

`./chordexport.sh <url>`

for example:

`./chordexport.sh https://chords-and-tabs.net/song/name/nancy-sinatra-something-stupid-2`

Example output:

```
G                  Em7           G7                  G
I know I stand in line until you think you have the time
            Am           D7    Am7   D7
To spend an evening with me
```

**Requirements**

  * bash
  * libxml2-utils
  * a terminal application capable of ANSI sequences (such as putty)
