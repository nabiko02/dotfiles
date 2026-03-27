# Bus 001 Device 008: ID 1532:0221 Razer USA, Ltd RZ03-0203 Gaming Keyboard [BlackWidow Chroma V2]

from openrazer.client import DeviceManager, constants as razer_constants
from random import randint
from enum import Enum
from random import shuffle

dm = DeviceManager()
dm.sync_effects = False


class Color(Enum):
    RED = "red"
    BLUE = "blue"
    GREEN = "green"


MAX_COLOR_VAL = 0xFF


class Pixel:
    def __init__(self):
        self.red = 0
        self.blue = 0
        self.green = 0
        self.order = [Color.RED, Color.BLUE, Color.GREEN]
        shuffle(self.order)

    def is_color_maxed_out(self, color):
        val = 0
        if color == Color.RED:
            val = self.red
        elif color == Color.BLUE:
            val = self.blue
        else:
            val = self.green
        return val % MAX_COLOR_VAL == 0

    def increase_color(self, color):
        if color == Color.RED and self.red < MAX_COLOR_VAL:
            self.red += 1
        elif color == Color.BLUE and self.blue < MAX_COLOR_VAL:
            self.blue += 1
        else:
            if self.green < MAX_COLOR_VAL:
                self.green += 1

    def reset(self):
        self.red = 0
        self.green = 0
        self.blue = 0

        shuffle(self.order)

    def get_color(self):
        return (self.red, self.green, self.blue)

    def process_pixel_color_value(self):
        for color in self.order:
            self.increase_color(color)
            if not self.is_color_maxed_out(color):
                break
            if color == self.order[-1]:
                self.reset()


def pattern(pixel: Pixel):
    for col in range(cols):
        for row in range(rows):
            pixel.process_pixel_color_value()
            advanced_fx.matrix[row, col] = pixel.get_color()
    advanced_fx.draw()


def random_color():
    y = randint(0, rows - 1)
    x = randint(0, cols - 1)
    red = randint(0, MAX_COLOR_VAL)
    green = randint(0, MAX_COLOR_VAL)
    blue = randint(0, MAX_COLOR_VAL)
    advanced_fx.matrix[y, x] = (red, green, blue)
    advanced_fx.draw()


def slider_random():
    for col in range(cols):
        for row in range(rows):
            red = randint(0, MAX_COLOR_VAL)
            green = randint(0, MAX_COLOR_VAL)
            blue = randint(0, MAX_COLOR_VAL)
            advanced_fx.matrix[row, col] = (red, green, blue)
#            advanced_fx.draw()
    advanced_fx.draw()

for device in dm.devices:
    print(f"device {device}")
    vid = str(hex(device._vid))[2:].upper().rjust(4, "0")
    pid = str(hex(device._pid))[2:].upper().rjust(4, "0")
    print(f"vid : {vid}")
    print(f"pid : {pid}")
    try:
        advanced_fx = device.fx.advanced
        print(advanced_fx)
        rows = advanced_fx.rows
        cols = advanced_fx.cols
        print(f"fx matrix rows {rows}")
        print(f"fx matrix cols {cols}")

        pixel = Pixel()
        # choice = randint(0, 2)
        # choice = 1
        # while True:
        #     if choice == 0:
        #         random_color()
        #     elif choice == 1:
        slider_random()
        # else:
        # pattern(pixel)
        break
    except Exception:
        print("")
