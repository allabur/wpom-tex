# wpom-tex

LaTeX class and example article for **WPOM, Working Papers on Operations Management** (Editorial Universitat Politècnica de València, <https://polipapers.upv.es/index.php/WPOM>).

This is an unofficial copy of the template, kept by Alberto Lacort. The class header says it is versioned from the Editorial UPV template.

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

There is no open licence yet. The class derives from the template of Editorial UPV, so the licence has to be agreed with the editorial first. The logos in `logos/` belong to the UPV and to WPOM. Until then, use it to prepare WPOM submissions and ask before reusing it elsewhere.

## Contact

alberto.lacort@upv.es
