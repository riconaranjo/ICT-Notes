# My Notes

These are my notes I wrote while working as an incircuit testing [ICT] coop at Sanmina. They encompass the most important things, as well as a general overview on how to use the Keysight 3070 for ICT. They are mostly based off the _Agilent 3070 User Fundamentals_ manuals, and my own personal experience. Do not assume these notes are entire correct since I wrote these while learning myself. Challenge everything that is written in here, and make sure it agrees with your understanding before accepting anything as fact.

In order to make the most of these notes you should have an understanding of the Keysight 3070 ICT testing system and basic circuit understanding. You should not view these notes as the most thorough reference but as supplementary / introductory material. I hope this helps you understand things better overall.

**Diclaimer:** These notes should not be considered as true reference, as these notes were written while I was learning, revised as best I could, and are most definitely imperfect.

## Table of Contents

- [BT-Basic Notes](BT-Basic%20Notes.md)
- [Board Consultant Notes](Board%20Consultant%20Notes.md)
- [Board Grading Notes](Board%20Grading%20Notes.md)
- [Files Notes](Files%20Notes.md)
- [General Notes](General%20Notes.md)
- [Part Descriptions](Part%20Descriptions.md)
- [Tests Notes](Tests%20Notes.md)

## Recommendations

This test system uses text files for everything; this means this job is mostly text file manipulation. **I strongly suggest using a modern text editor**, especially [Visual Studio Code](https://code.visualstudio.com) because it allows for regex search and replace, multiline editing, and syntax folding [press <kbd>ctrl</kbd> + <kbd>k</kbd> followed by <kbd>ctrl</kbd> + <kbd>0</kbd> in the `board` file to see what I mean]. Runner ups: Sublime Text, Atom, Brackets.

## VS Code

VS Code also has the added benefit of easy viewing of markdown files [`.md`], the format which these notes were originally written in. If you open a `.md` file you can open a preview of the files and read them with all the syntax highlighing and formatting applied.

If any changes need to be made to these notes, they can be made to the `.md` files, and with the `Markdown PDF` extension they can be exported to pdf, which may be the format you're reading these notes in.

## Markdown

These notes were writen using markdown, which is a simple language that allows you to format pages and documents, without having to know things like HTML.

This is a quick reference:

    # Title
    ## Header 1
    ### Header 2
    #### Header 3
    - bullet point layer 1
      - bullet point layer 2
        - bullet point layer 3
    _This text is italicized_
    *This text is also italicized*
    **This text is bold**

And this is what the above text will output.

# Title
## Header 1
### Header 2
#### Header 3
- bullet point layer 1
  - bullet point layer 2
    - bullet point layer 3
_This text is italicized_
*This text is also italicized*
**This text is bold**


