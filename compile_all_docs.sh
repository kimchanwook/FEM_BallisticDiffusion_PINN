#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
latexmk -pdf -interaction=nonstopmode -halt-on-error project_plan.tex
cd "$ROOT/docs/physics_notes"
for f in *.tex; do
  latexmk -pdf -interaction=nonstopmode -halt-on-error "$f"
done
cd "$ROOT/docs/slides"
for f in *.tex; do
  latexmk -pdf -interaction=nonstopmode -halt-on-error "$f"
done
