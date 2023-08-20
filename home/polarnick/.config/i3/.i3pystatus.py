# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

notebook = False
nvidia_gpu = False

disks = [
    ("~/data", "/home/polarnick/data/"),
    ("~/shared", "/home/polarnick/shared/"),
    ("/", "/"),
    ("home", "/home"),
]

status = Status(standalone=True)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="{volume_bar} ♪",
    color_muted="#FFAAAA",)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%a %-d %b %X",)

if nvidia_gpu:
    # Shows your GPU memory usages, if you have a Nvidia GPU
    status.register("gpu_mem",
        format="GPU RAM: {used_mem}/{total_mem} Mb",
        color="#AAFFAA",
        warn_color="#FFFF55",
        interval=1,)

    # Shows your GPU temperature, if you have a Nvidia GPU
    status.register("gpu_temp",
        format="GPU: {temp}°C",
        color="#AAFFAA",
        interval=1,)

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    lm_sensors_enabled=True,
    format="CPU: {temp:.0f}°C",
    color="#AAFFAA",)

status.register("cpu_usage_graph",
    start_color="#AAFFAA",
    end_color="#FFAAAA")

status.register("mem",
    format="Used RAM: {used_mem}/{total_mem} Mb",
    color="#AAFFAA",
    warn_color="#FFFF55",
    warn_percentage=60,
    alert_percentage=80)

if notebook:
    # This would look like this:
    # Discharging 6h:51m
    status.register("battery",
        format="{status} {remaining:%E%h:%M}",
        not_present_text="No battery",
        alert=True,
        alert_percentage=20,
        status={
            "DIS":  "Battery ",
            "CHR":  "Battery ⚡",
            "FULL": "Battery ✔",
        },
        full_color="#AAFFAA",
        charging_color="#AAFFAA",
        not_present_color='#AAFFAA')

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="eth0", # use "ip link show" to choose the proper one
    format_up="E: {v4}",
    format_down="E: no",
    color_up="#AAFFAA",
    color_down="#AAAAFF",)

if notebook:
    # Has all the options of the normal network and adds some wireless specific things
    # like quality and network names.
    #
    # Note: requires both netifaces and basiciw
    status.register("network",
        interface="wlan0",
        format_up="📶: {quality:.0f}% at {essid} {v4}",
        format_down = "📶: no",
        color_up="#AAFFAA",
        color_down="#AAAAFF",)

# Shows disk usage
for label, path in disks:
    status.register("disk",
                    path=path,
                    format=label + " {avail:.1f}/{total:.1f} Gb",
                    color="#AAFFAA",
                    critical_color="#FFAAAA",
                    critical_limit=5)

status.run()
