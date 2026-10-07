#!/usr/bin/env python3
# ~/.config/conky/scripts/line_height.py
# Usage: line_height.py "<font_name>" <font_size>
# Prints the font's true recommended line height in pixels.

import sys
import subprocess
import freetype

def main():
    if len(sys.argv) != 4:
        print("Usage: line_height.py <font_name> <font_size> <dpi>", file=sys.stderr)
        sys.exit(1)

    font_name = sys.argv[1]
    font_size = int(sys.argv[2])
    dpi = int(sys.argv[3])

    # resolve family name -> actual font file path via fontconfig
    result = subprocess.run(
        ["fc-match", "-f", "%{file}", font_name],
        capture_output=True, text=True
    )
    font_path = result.stdout.strip()
    if not font_path:
        print(f"Could not resolve font file for '{font_name}'", file=sys.stderr)
        sys.exit(1)

    face = freetype.Face(font_path)
    face.set_char_size(font_size * 64, 0, dpi, dpi)  # 26.6 fixed-point, size in 1/64th points

    ascender = face.size.ascender / 64
    descender = abs(face.size.descender / 64)
    line_height = round(ascender + descender)

    print(line_height)

if __name__ == "__main__":
    main()
