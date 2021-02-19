# lib/adafruit_hid/mouse.mpy
# lib/adafruit_hid/__init__.mpy

import time
import board
import digitalio
import usb_hid
from adafruit_hid.mouse import Mouse
from analogio import AnalogIn

mouse = Mouse(usb_hid.devices)
A9 = AnalogIn(board.A9)
A10 = AnalogIn(board.A10)

click = digitalio.DigitalInOut(board.D8)
click.direction = digitalio.Direction.INPUT
click.pull = digitalio.Pull.UP

switch_state = True

speed = 0
default_speed = 5
max_speed = 40
accel_range = max_speed - default_speed

accel_time_range = 0.8
accel_time = 0
time_step = 0.04

accel_factor = 0.0
accel_speed = 0

#accel_curve = [0, 0.1, 0.1, 0.2, 0.3, 0.5, 0.8, 1.0]

accel_curve = [
    0,
    0.01,
    0.01,
    0.01,
    0.02,
    0.02,
    0.03,
    0.04,
    0.05,
    0.06,
    0.08,
    0.1,
    0.12,
    0.15,
    0.18,
    0.22,
    0.27,
    0.32,
    0.38,
    0.44,
    0.5,
    0.56,
    0.62,
    0.68,
    0.73,
    0.78,
    0.82,
    0.85,
    0.88,
    0.9,
    0.92,
    0.94,
    0.95,
    0.96,
    0.97,
    0.98,
    0.98,
    0.99,
    0.99,
    0.99,
    0.99,
]

while True:
    x_factor = (A10.value / 65535) - 0.5
    y_factor = (A9.value / 65535) - 0.5

    power = max(abs(x_factor), abs(y_factor))

    if power > 0.1:
        accel_time += time_step
        accel_factor = accel_time / accel_time_range
        if accel_factor > 1:
            accel_factor = 1
    else:
        accel_factor = 0
        accel_time = 0

    speed = (
        default_speed
        + accel_range * accel_curve[int((len(accel_curve) - 1) * accel_factor)]
    )
    mouse.move(x=-int(x_factor * speed), y=-int(y_factor * speed))

    if not click.value and switch_state is True:
        mouse.click(Mouse.LEFT_BUTTON)
    switch_state = click.value

    print(int(switch_state), accel_time, speed / 10)

    time.sleep(time_step)

table = [
    0,
    0.01,
    0.01,
    0.01,
    0.02,
    0.02,
    0.03,
    0.04,
    0.05,
    0.06,
    0.08,
    0.1,
    0.12,
    0.15,
    0.18,
    0.22,
    0.27,
    0.32,
    0.38,
    0.44,
    0.5,
    0.56,
    0.62,
    0.68,
    0.73,
    0.78,
    0.82,
    0.85,
    0.88,
    0.9,
    0.92,
    0.94,
    0.95,
    0.96,
    0.97,
    0.98,
    0.98,
    0.99,
    0.99,
    0.99,
    0.99,
]
