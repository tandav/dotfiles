import svg
from colortool import Color


class ColorGrid:
    def __init__(
        self,
        colors: list[list[Color]],
        labels: list[str] | None = None,
        rect_width: int = 100,
        rect_height: int = 30,
    ):
        if labels is not None and len(labels) != len(colors):
            raise ValueError('len(labels) must be equal len(colors)')
        self.colors = colors
        self.labels = labels
        self.rect_width = rect_width
        self.rect_height = rect_height
        self.height = self.rect_height * len(colors)
        self.width = self.rect_width * max(map(len, colors))

    @classmethod
    def stack(
        cls,
        colors: list[Color],
        labels: list[str] | None = None,
        rect_width: int = 100,
        rect_height: int = 30,
    ):
        return cls(colors=[[c] for c in colors], labels=[[l] for l in labels], rect_width=rect_width, rect_height=rect_height)

    @classmethod
    def row(
        cls,
        colors: list[Color],
        labels: list[str] | None = None,
        rect_width: int = 100,
        rect_height: int = 30,
    ):
        return cls(colors=[colors], labels=[labels], rect_width=rect_width, rect_height=rect_height)


    def _repr_svg_(self):
        Y = range(0, self.rect_height * len(self.colors), self.rect_height)
        X = range(0, self.rect_width * len(self.colors), self.rect_width)
        elements = []
        for i, row in enumerate(self.colors):
            for j, color in enumerate(row):
                y = Y[i]
                x = X[j]
                rect = svg.Rect(
                    x=x,
                    y=y,
                    width=self.rect_width,
                    height=self.rect_height,
                    fill=color.css_hex,
                )
                elements.append(rect)
                if self.labels is None:
                    continue
                text = svg.Text(
                    x=x + self.rect_width // 2,
                    y=y + self.rect_height // 2,
                    text=self.labels[i][j],
                    font_size=14,
                    font_family='monospace',
                    text_anchor='middle',
                    dominant_baseline='middle',
                )
                elements.append(text)
        outline = svg.Rect(
            x=0,
            y=0,
            width=self.width,
            height=self.height,
            fill='none',
            stroke=Color(0xFFFFFF),
        )
        elements.append(outline)
        return str(svg.SVG(width=self.width, height=self.height, elements=elements))
