import pytest
import math
from colortool import Color
from dsplib.scale import minmax_scaler


class Gradient:
    def __init__(self, colors: tp.List[Color]) -> None:
        self.colors = colors

    def __call__(self, i: float) -> Color:
        if not 0 <= i <= 1:
            raise ValueError('i must be in 0..1 range')
        j = minmax_scaler(i, 0, 1, 0, len(self.colors) - 1)
        ja = int(j)
        jb = min(ja + 1, len(self.colors) - 1)
        k, _ = math.modf(j)
        kb = minmax_scaler(k, 0, 1, 0, 0xFF)
        rgb_a = self.colors[ja].rgb_int
        rgb_b = self.colors[jb].rgb_int
        rgb = tuple(
            int(minmax_scaler(kb, 0, 0xFF, channel_a, channel_b))
            for channel_a, channel_b in zip(rgb_a, rgb_b)
        )
        return Color.from_rgb_int(rgb)  # type: ignore[arg-type]


    def _repr_svg_(self):
        raise NotImplementedError('TODO')



@pytest.fixture
def gradient():
    _colors = [0x845EC2, 0xD65DB1, 0xFF6F91, 0xFF9671, 0xFFC75F, 0xF9F871]
    return Gradient([Color(c) for c in _colors])


@pytest.mark.parametrize(
    ('color', 'expected'), [
        (0.0, 0x845EC2),
        (0.2, 0xD65DB1),
        (0.4, 0xFF6F91),
        (0.6, 0xFF9671),
        (0.8, 0xFFC75F),
        (0.9, 0xFCDF68),
        (1.0, 0xF9F871),
    ],
)
def test_gradient(gradient, color, expected):
    assert gradient(color) == Color(expected)
