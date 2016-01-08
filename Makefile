RELEASE_VERSION = 0.4

ifndef PREFIX
  PREFIX=/usr/local
endif
ifndef SYSCONFDIR
  ifeq ($(PREFIX),/usr)
    SYSCONFDIR=/etc
  else
    SYSCONFDIR=$(PREFIX)/etc
  endif
endif
ifndef LIBDIR
  LIBDIR=$(PREFIX)/lib
endif

INSTALL_BIN=/usr/bin

install:
	install -m 644 -o root -g root data/udev/90-HOTPLUG_display-visor.rules $(SYSCONFDIR)/udev/rules.d/
	install -m 644 -o root -g root data/acpid/LID_display-visor $(SYSCONFDIR)/acpi/events/
	install -m 744 -o root -g root data/systemd-sleep/WAKEUP_display-visor.sh $(LIBDIR)/systemd/system-sleep/
	install -m 744 -o root -g root src/display-visor.sh $(DESTDIR)$(PREFIX)/
	
uninstall:
	rm $(SYSCONFDIR)/udev/rules.d/90-HOTPLUG_display-visor.rules
	rm $(SYSCONFDIR)/acpi/events/LID_display-visor
	rm $(LIBDIR)/systemd/system-sleep/WAKEUP_display-visor.sh
	rm $(DESTDIR)$(PREFIX)/display-visor.sh
