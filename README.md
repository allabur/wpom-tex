# wpom-tex

LaTeX class and example article for **WPOM, Working Papers on Operations Management** (Editorial Universitat Politècnica de València, <https://polipapers.upv.es/index.php/WPOM>).

The class and the example are the work of Alberto Lacort. Editorial UPV has permission to use them for WPOM. See [Licence](#licence).

## Files

| File | What it is |
|---|---|
| `wpom-upv.cls` | The document class |
| `main.tex` | Example article. Start here |
| `references.bib` | Example bibliography |
| `figures/` | Example figure |
| `logos/` | WPOM logo and the CC BY badge |

## How to use

1. Fill in the metadata block at the top of `main.tex` (title, authors, dates, DOI).
2. Replace the body sections with your text.
3. Put your references in a `.bib` file. WPOM asks for APA 7th style, which `main.tex` sets through `biblatex` (backend `biber`).
4. Compile with `latexmk -pdf main.tex`. It needs `biber`.

Class options, which can be combined:

- `anonymous`: blind review version.
- `preprint`: preprint version.
- `nomathskip`: do not change the spacing around equations.

```latex
\documentclass[preprint,anonymous]{wpom-upv}
```

## Licence

Copyright (c) 2026 Alberto Lacort. All rights reserved. See [LICENSE](LICENSE).

Alberto Lacort holds the copyright of the class and the example. He has granted Editorial UPV the right to use them for WPOM. No other licence is granted: to reuse or modify the files for another purpose, ask the author.

The logos in `logos/` belong to the UPV and WPOM, and to Creative Commons. They are not covered by this licence.

## Contact

alberto.lacort@upv.es
