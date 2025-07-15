#!/bin/bash

NOW=$(date +%-A-%-b-%-d-%-I:%-M:%-S:%-N_%p)

if [ -d "~/Screenshots" ]; then
  grim -g "$(slurp)" ~/Screenshots/screencut-$NOW.png
else
  mkdir -p ~/Screenshots
  grim -g "$(slurp)" ~/Screenshots/screencut-$NOW.png
fi