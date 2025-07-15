#!/bin/bash

NOW=$(date +%-A-%-b-%-d-%-I:%-M:%-S:%-N_%p)

if [ -d "~/Screenshots" ]; then
  grim ~/Screenshots/screenshot-$NOW.png
else
  mkdir -p ~/Screenshots
  grim ~/Screenshots/screenshot-$NOW.png
fi