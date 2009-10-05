all: install

install:
	install -d $(DESTDIR)/bin
	install -d $(DESTDIR)/usr/lib/microde
	install -D -m755 src/microde.sh $(DESTDIR)/bin/microde
	cp -ax src/lib/*                $(DESTDIR)/usr/lib/microde/
	install -D -m644 README $(DESTDIR)/usr/share/microde/docs

uninstall:
	rm -f  $(DESTDIR)/bin/microde
	rm -rf $(DESTDIR)/usr/share/microde
	rm -rf $(DESTDIR)/usr/lib/microde
