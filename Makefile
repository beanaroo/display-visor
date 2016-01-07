INSTALL_BIN=/usr/bin

install:
	install -m 644 -o root -g root data/udev/90-HOTPLUG_display-supervisor.rules /etc/udev/rules.d/
	install -m 644 -o root -g root data/acpid/LID_display-supervisor /etc/acpi/events/
	install -m 744 -o root -g root data/systemd-sleep/WAKEUP_display-supervisor.sh /usr/lib/systemd/system-sleep/
	install -m 744 -o root -g root src/display-supervisor.sh ${INSTALL_BIN}/
	
uninstall:
	rm /etc/udev/rules.d/90-HOTPLUG_display-supervisor.rules
	rm /etc/acpi/events/LID_display-supervisor
	rm /usr/lib/systemd/system-sleep/WAKEUP_display-supervisor.sh
	rm ${INSTALL_BIN}/display-supervisor.sh
