INSTALL_BIN=/usr/bin

install:
	install -m 644 -o root -g root data/udev/90-HOTPLUG_display-visor.rules /etc/udev/rules.d/
	install -m 644 -o root -g root data/acpid/LID_display-visor /etc/acpi/events/
	install -m 744 -o root -g root data/systemd-sleep/WAKEUP_display-visor.sh /usr/lib/systemd/system-sleep/
	install -m 744 -o root -g root src/display-visor.sh ${INSTALL_BIN}/
	
uninstall:
	rm /etc/udev/rules.d/90-HOTPLUG_display-visor.rules
	rm /etc/acpi/events/LID_display-visor
	rm /usr/lib/systemd/system-sleep/WAKEUP_display-visor.sh
	rm ${INSTALL_BIN}/display-visor.sh
