display-visor
==================

i3 does not manage displays and I move my laptop around a lot. This little script fills a much needed gap in my tiling window manager setup.

How it works
------------
When executed, it checks the available and connected display outputs and sets the optimal resolution for each (as determined by xrandr). It can then also reset the wallpaper. The script then waits for a signal to restart the procedure.

At the moment I have three outputs defined: `LVDS1`, `HDMI1` and `VGA1`. For now, layout configuration is hard-coded. I am hoping to make this more dynamic.

When lid is open (`-l`): LVDS (Primary) on left with HDMI or VGA on right. 
My laptop can only handle two displays at a time, so if both HDMI and VGA are present, or... 

When lid is closed: HDMI (Primary) on left with VGA on right.

If you prefer, you could of course use [arandr](https://christian.amsuess.com/tools/arandr/) to generate layout scripts and replace my xrandr lines with those.

How to use it
------------

    Usage: display-visor [-f] [-i] [-l [switch]]

		-f, --feh	Run feh bg script.
                             Executes ~/.fehbg upon completion.
		-i, --i3	Test for i3wm instance.
                             For avoiding conflict with multiple environments.
		-l, --lid	Check laptop lid status.
                             Ignored/Assumed closed if not given. 
                             It is possible to specify switch. Defaults to 'LID0'
                             If unsure, look under /proc/acpi/button/lid/...
		-v, --version	Print version info.


##### Start:
Simply set the script to start upon login.

i3wm config example:

    exec --no-startup-id display-visor -f -l

##### Signal:
The script waits for a `RTMIN+5` real-time signal. This can be sent with pkill like so:

    pkill -x -RTMIN+5 display-visor

##### Events:
Some default event signallers are included.

 * __udev__ - A hotplug rule for when cables are (dis)connected.
 * __acpid__ - A lid switch event action. Useful when `-l` argument is used. [1]
 * __systemd-sleep__ - A wake-up hook. [2]

Installation
------------
 * Arch Linux - Available on the [AUR](https://aur.archlinux.org/packages/display-visor) as `display-visor`

Or manually with:

    $ sudo make (un)install

Dependencies
------------
* [xorg-xrandr](http://www.x.org/wiki/Projects/XRandR/)
* [acpid](http://sourceforge.net/projects/acpid2/)(for lid events)

Notes
-----
 [1] Remember to restart `acpid` service for this to take effect.
 [2] Please see [Issue #8](https://github.com/beanaroo/display-visor/issues/8)

----
####Credits
I shamelessly stole some base functionality from [codingtony](https://github.com/codingtony/udev-monitor-hotplug). Thank you, kind sir.
