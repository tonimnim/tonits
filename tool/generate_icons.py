"""Render the Tonits launcher icon sources from assets/brand/mark.svg.

The mark is drawn only with straight segments (M/L/Z) and an even-odd fill,
so it rasterises with Pillow alone. Run from the project root:

    python3 tool/generate_icons.py
    dart run flutter_launcher_icons
"""

import re

from PIL import Image, ImageDraw

INDIGO = (91, 91, 214, 255)  # dashboard --primary, #5B5BD6
WHITE = (255, 255, 255, 255)
SIZE = 1024
SUPERSAMPLE = 4

svg = open("assets/brand/mark.svg").read()
min_x, min_y, box, _ = (float(v) for v in re.search(r'viewBox="([^"]+)"', svg).group(1).split())
path = re.search(r' d="([^"]+)"', svg).group(1)
subpaths = [
    [tuple(map(float, pair)) for pair in re.findall(r"[ML]\s*([\d.]+)\s+([\d.]+)", chunk)]
    for chunk in path.split("Z")
    if chunk.strip()
]


def mark(fraction: float, colour, background) -> Image.Image:
    """The mark centred on a square canvas, `fraction` of its width."""
    size = SIZE * SUPERSAMPLE
    scale = size * fraction / box
    offset = size * (1 - fraction) / 2
    # Even-odd: XOR every subpath into a mask, so the buttons are cut out.
    mask = Image.new("1", (size, size), 0)
    for points in subpaths:
        layer = Image.new("1", (size, size), 0)
        ImageDraw.Draw(layer).polygon(
            [((x - min_x) * scale + offset, (y - min_y) * scale + offset) for x, y in points],
            fill=1,
        )
        mask = Image.frombytes("1", mask.size, bytes(a ^ b for a, b in zip(mask.tobytes(), layer.tobytes())))
    canvas = Image.new("RGBA", (size, size), background)
    canvas.paste(Image.new("RGBA", (size, size), colour), mask=mask)
    return canvas.resize((SIZE, SIZE), Image.LANCZOS)


# iOS and legacy Android: opaque, the mark at 60% on indigo.
mark(0.60, WHITE, INDIGO).convert("RGB").save("assets/brand/app-icon-1024.png")
# Android adaptive layers: the mark inside the 66% safe zone.
mark(0.50, WHITE, (0, 0, 0, 0)).save("assets/brand/android-adaptive-foreground-1024.png")
mark(0.50, WHITE, (0, 0, 0, 0)).save("assets/brand/android-adaptive-monochrome-1024.png")
print("wrote assets/brand/app-icon-1024.png and the adaptive layers")
