# Pandoc Lua filter example with tabularray

A proof of concept of a Lua filter for [Pandoc](https://pandoc.org/) in order to create Markdown tables and use [Tabularray](https://ctan.org/pkg/tabularray) when creating a PDF.

Tabularray has a lot tweaks to generate a very good tables(see the [documentation](https://ctan.javinator9889.com/macros/latex/contrib/tabularray/tabularray.pdf)), but this filter only create the basic table structure.

This filter will be added to my [Pandoc Template](https://github.com/yuki/pandoc-templates), so maybe this repository could be outdated. I don't use cell-colors and other feature, so probably I will not add it to the filter.

## The LaTeX example

There's an `latex_example.tex` file to see how is the real environment in LaTeX. To create the PDF you can execute:

```pdflatex latex_example.tex```

## The Markdown example

To create this example I have created a very basic template (file: `template/latex.tex`), that is like the LaTeX example. The markdown file is `markdown_example.md`and you can generate the PDF with Pandoc:

```pandoc -f markdown-markdown_in_html_blocks+table_captions markdown_example.md --template=template/latex.tex --lua-filter=filter.lua -o markdown_example.pdf --verbose```

## What the filter does

As you can see in the markdown file, the table code is:

```
| Head 1 | Head 2  | Head 3 | 
|:-------|:-------:|-------:|
| Alpha  | Beta    | Gamma  | 
| Delta  | Epsilon | Zeta   |
| Eta    | Theta   | Iota |

Table: Table content {tablename=yukitblr}
```

And what I have done with the filter is parse it and generate the next LaTeX code for Tabularray:

```
\begin{yukitblr}[caption={Table content }]{X[l]X[c]X[r]}

Head 1 & Head 2 & Head 3 \\ 

Alpha & Beta & Gamma \\ 
Delta & Epsilon & Zeta \\ 
Eta & Theta & Iota \\ 

\end{yukitblr}
```

If you want to see how is the generated LaTeX file before the PDF creation you can execute:

```pandoc -f markdown-markdown_in_html_blocks+table_captions markdown_example.md --template=template/latex.tex --lua-filter=filter.lua -o markdown_example.tex --verbose ```


## HTML example

I have added a table in HTML that is parsed too with the filter. HTML is very complex compared to Markdown, so right now there are features that are in the HTML that are not parset into Tabularray-LaTeX.


## Extra

The filter also works when parsing to HTML, so the generated HTML table will have "data-tablename" as an attribute. To generate the HTML output file:

```pandoc -f markdown-markdown_in_html_blocks+table_captions markdown_example.md --lua-filter=filter.lua -o markdown_example.html --verbose```