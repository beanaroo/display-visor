RELEASE_VERSION = 0.4

ifndef PREFIX
  PREFIX=/usr/local
endif
ifndef SYSCONFDIR
    SYSCONFDIR=/etc
endif
ifndef LIBDIR
  LIBDIR=/usr/lib
endif

install:
	install -Dm 644 data/udev/90-HOTPLUG_display-visor.rules ${DESTDIR}${SYSCONFDIR}/udev/rules.d/90-HOTPLUG_display-visor.rules
	install -Dm 644 data/acpid/LID_display-visor ${DESTDIR}${SYSCONFDIR}/acpi/events/LID_display-visor
	install -Dm 744 data/systemd-sleep/WAKEUP_display-visor.sh ${DESTDIR}${LIBDIR}/systemd/system-sleep/WAKEUP_display-visor.sh
	install -Dm 755 src/display-visor ${DESTDIR}${PREFIX}/bin/display-visor
	
uninstall:
	rm ${SYSCONFDIR}/udev/rules.d/90-HOTPLUG_display-visor.rules
	rm ${SYSCONFDIR}/acpi/events/LID_display-visor
	rm ${LIBDIR}/systemd/system-sleep/WAKEUP_display-visor.sh
	rm ${DESTDIR}${PREFIX}/display-visor
