---
name: paper
description: Style rules for writing/editing academic Typst papers (main.tex, chapters/*.tex, acronyms). Use whenever editing a Typst paper's prose, titles, headings, or acronyms.
---

# Paper style rules

Apply these whenever writing or editing text in a Typst paper (e.g. `main.tex`, `chapters/*.tex`):

- Use UK spelling.
- Capitalise all titles.
- Use `\gls` for acronyms, defined in a `acronyms.tex` file. Never expand common acronyms like HTML5 or SVG inline.
- No newline between a heading and its following content.
- Every figure must be referenced from the text (e.g. `@fig-...`); no orphan figures.

## Removing runt lines (one-word paragraph overhangs)

Compile the PDF, then detect paragraphs whose last line is under 25% of the column width:

```python
import fitz, sys
d = fitz.open(sys.argv[1])
for pno, p in enumerate(d, 1):
    for b in p.get_text("dict")["blocks"]:
        if b["type"] != 0 or len(b["lines"]) < 2: continue
        ws = [l["bbox"][2] - l["bbox"][0] for l in b["lines"]]
        if ws[-1] < 0.25 * max(ws):
            print(pno, "".join(s["text"] for s in b["lines"][-1]["spans"]))
```

Run with ⁠ `uv run --with pymupdf python runts.py main.pdf ⁠.`

- ⁠Grep the reported tail text in ⁠ chapters/*.tex to locate the source sentence.
- ⁠Shorten by 2-4 words, preferring wordy phrases elsewhere in the same paragraph ("makes it possible to differentiate between" -> "differentiates", "is in line with" -> "follows", "allows the user to" -> "lets the user"). Never cut meaning or citations.
- ⁠Recompile and rerun the detector; fixes shift the layout, so iterate until it reports nothing.

## Filling in missing DOIs in references.bib

For bib entries missing a `doi` field, query Crossref (no auth needed) and add it:

```bash
curl -s "https://api.crossref.org/works?query.bibliographic=<title/author words>&rows=1" \
  | python3 -c "import json,sys;d=json.load(sys.stdin)['message']['items'][0];print(d.get('DOI'),d.get('title'))"
```

- Build the query from the entry's title and first author.
- Verify the returned title actually matches before adding the DOI - Crossref sometimes returns a wrong best-guess match, especially for tech reports/datasets not indexed by Crossref at all. Skip those rather than attaching an incorrect DOI.
- Add `doi = {...}` as the last field in the entry, matching existing field alignment.