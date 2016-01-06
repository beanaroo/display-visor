Display Supervisor
==================

i3 does not manage displays and I move my laptop around a lot. This little script fills a much needed gap in my tiling window manager setup.

How it works
------------
    Usage: display-supervisor [-f] [-i] [-l [switch]]

		-f, --feh	Run feh bg script.
                             Executes ~/.fehbg upon completion.
		-i, --i3	Test for i3wm instance.
                             For avoiding conflict with multiple environments.
		-l, --lid	Check laptop lid status.
                             It is possible to specify switch. Defaults to 'LID0'
                             If unsure, look under /proc/acpi/button/lid/...
		-v, --version	Print version info.

When executed, it checks the available and connected display outputs and sets the optimal resolution for each (as determined by xrandr). It can then also reset the wallpaper.
At the moment I have three outputs defined: `LVDS1`, `HDMI1` and `VGA1`. For now, layout configuration is hard-coded. I am hoping to make this more dynamic.

When lid is open: LVDS (Primary) on left with HDMI or VGA on right.
My laptop can only handle two displays at a time, so if both HDMI and VGA are present, or lid is closed: HDMI (Primary) on left with VGA on right.

You could of course use `arandr` to generate layout scripts and replace my xrandr lines with those.

How I use it
------------

##### User Login:
Added as `exec` to i3 config.

##### Monitor hotplug:
Created the following udev rule in `/etc/udev/rules.d/20-display-supervisor.conf`:

    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", RUN+="/path/to/display-supervisor.sh -f -l"

##### Laptop lid open/close:
Using acpid with the following rules in `/etc/acpi/handler.sh`:

    ...
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                /path/to/display-supervisor.sh -f -l
                ;;
            open)
                logger 'LID opened'
                /path/to/display-supervisor.sh -f -l
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
        esac
        ;;
    ...

##### System resume:
Create a wake-up script `/usr/lib/systemd/system-sleep/initiate-display-supervisor.sh`:

    #!/bin/sh
    case $1/$2 in
      pre/*)
        exit 0
        ;;
      post/*)
        echo "Waking up from $2... Refreshing displays."
        $(/path/to/display-supervisor.sh·-f·-l)
        ;;
    esac

Remember to mark as executable.

Dependencies
------------
* xorg-xrandr
* acpid (for lid events)

Notes
-----
In all of the above usages, besides user login, the script is run as root user by the system. This requires the use of a `getXuser()` function to find `$DISPLAY` and `$XAUTHORITY` needed by `xrandr`. Running as user (upon login) then only works when launching sessions with `startx` instead of a display manager. I am looking into a better method.

To-do
----
- [ ] Add an option for custom bg script.
- [ ] Daemonize script and use real-time signals instead.
- [ ] Layout flexibility.
- [ ] OSD?

----
####Credits
I shamelessly stole some base functionality from [codingtony](https://github.com/codingtony/udev-monitor-hotplug). Thank you, kind sir.
