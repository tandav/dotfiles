import math
import typing as tp
import svg
from colortool import Color


RectData = dict[str, tp.Any]


class ColorGrid:
    def __init__(
        self,
        rects: list[list[RectData]],
        rect_width: int = 30,
        rect_height: int = 30,
        background_color: Color | None = None,
        outline_width: int = 0,
    ):
        self.rects = rects
        self.rect_width = rect_width
        self.rect_height = rect_height
        self.height = self.rect_height * len(rects)
        self.width = self.rect_width * max(map(len, rects))
        self.background_color = background_color
        self.outline_width = outline_width

    @classmethod
    def stack(cls, rects: list[RectData], **kw):
        return cls(rects=[[r] for r in rects], **kw)

    @classmethod
    def row(cls, rects: list[RectData], **kw):
        return cls(rects=[rects], **kw)

    @classmethod
    def pack_into_matrix(cls, lst: list[RectData], **kw):
        if len(lst) == 0:
            return []
        n = math.isqrt(len(lst))
        if n * n != len(lst):
            n += 1
        matrix = [lst[i:i + n] for i in range(0, len(lst), n)]
        return cls(rects=matrix, **kw)

    def _repr_svg_(self):
        Y = range(0, self.rect_height * (len(self.rects) + 1), self.rect_height)
        X = range(0, self.rect_width * (len(self.rects) + 1), self.rect_width)
        elements = []
        if self.background_color is not None:
            elements.append(svg.Rect(
                x=0,
                y=0,
                width=self.width,
                height=self.height,
                fill=self.background_color.css_hex,
                stroke='none',
            ))
        for i, row in enumerate(self.rects):
            for j, rect in enumerate(row):
                y = Y[i]
                x = X[j]
                color = rect.get('color')
                if color is not None:
                    elements.append(svg.Rect(
                        x=x,
                        y=y,
                        width=self.rect_width,
                        height=self.rect_height,
                        fill=color.css_hex,
                    ))
                text = rect.get('text')
                if text is not None:
                    elements.append(svg.Text(
                        x=x + self.rect_width // 2,
                        y=y + self.rect_height // 2,
                        text=text,
                        font_size=14,
                        font_family='monospace',
                        text_anchor='middle',
                        dominant_baseline='middle',
                    ))
        if self.outline_width:
            elements.append(svg.Rect(
                x=0,
                y=0,
                width=self.width,
                height=self.height,
                fill='none',
                stroke=Color(0x000000).css_hex,
                stroke_width=self.outline_width,
            ))
        return str(svg.SVG(width=self.width, height=self.height, elements=elements))
