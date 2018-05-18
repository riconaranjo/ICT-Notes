# BT-Basic Notes

The Board Test-BASIC text editor used to modify the test suite. It is mostly based of Unix commands but differs slightly. It is used because it will automatically update file's header infomration that the i3070 programs use.

- You can use either single quotes `'` or double quotes `"`.
- Some files need to be compiled into object and list files to be run on test fixture.
  - **board**, **board\_xy**, and files in the library folders [defined below]
- Comments are written with `!` [`! this is a comment`]
  - All changes should be clearly commented as well as why the changes were made, and by whom.

## Function Keys

- `F1:` **Edit / Command** [move cursor between workspace and command line]
- `F2:` **Recall Plus** [recall previous commands, use with F3]
- `F3:` **Recall Minus** [recall previous command but less recent direction]
- `F4:` **Execute** [normally same as <kbd>enter</kbd>]
- `F5:` **Mark / Second Mark / Clear Mark** [for selecting an area of code]
- `F6:` **Test Consultant** [opens test consultant]
- `F7:` **Pushbutton Q-Stats** [starts the Quality Statistics]
- `F8:` **Store Line** [allows you to move a line]
- `F9:` **Insert Line** [inserts one black line into workspace]
- `F10:` **Delete Line** [...from workspace]
- `F11:` **Clear Line** [Deletes all characters to the right of the cursor]
- `F12:` **Clear Display** [reloads the window]

## Commands

- `board consulant` Use this to open the board consultant [short: `board cons`]
- `cat` lists all the directories and then files in the current file path location.
- `cd "<directory>"` change directory to file path [also: `msi`]
- `change "<string>" to "<string>"` change _string_ through the file
- `changem "<string>" to "<string>"` change _string_ within marked text
- `changen "<string>" to "<string>"` change next occurance of _string_
- `copy "<source>" to "<destination>"` copy file to file path [overwrite with `over` instead of `to`]
- `check board "<file>", error` Use this to check the syntax on the file, with errors returned in variable `error`;
  - use this before compilation of _board_ and _board\_xy_.
- `delete` delete marked text
- `duplicate` duplicate marked text
- `edit <linenumber>` go to line [if no number, line 1 default]
- `fetch <linenumber>` copy specified line to command line
- `find "<string>"` find first occurrence of string
- `findm "<string>"` find string in marked text
- `findn "<string>"` find next occurrence of string
- `get "<file>"` open file [also: `load`]
- `get part "<file>"` open part library [also: `load`]
- `list "<file>"` prints file in workspace with line numbers
- `save "<file>"` saves current workspace to a file with specified name
- `savem "<file>"` saves marked text to a with specified name
- `re-save` saves any changes to current file in workspace
- `scratch` discard contents of workspace
- `unlink "<file>"` delete file
- `;win` use this at the end of a command to open in a new window

`// using ';' after a command denotes optional parameters`

## Numerals

You can use numerals suffixes to specify component values and other numbers.

| Suffix | Desription | 10^x |
|--------|------------|:----:|
| **M**  | _Mega_     | 6    |
| **k**  | _kilo_     | 3    |
| **m**  | _milli_    | -3   |
| **u**  | _micro_    | -6   |
| **n**  | _nano_     | -9   |
| **p**  | _pico_     | -12  |

## Definitions

- `ed` extra digit [use when testing at 128 Hz]
- `en` enhanced [more accurate meaurement]