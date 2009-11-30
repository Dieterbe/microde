all: install

install:
	install -d $(DESTDIR)/usr/bin
	install -d $(DESTDIR)/usr/lib/microde
	install -d $(DESTDIR)/usr/share/microde/examples
	install -d $(DESTDIR)/usr/share/microde/docs
	install -D -m755 src/microde.sh $(DESTDIR)/usr/bin/microde
	cp -ax src/lib/*                $(DESTDIR)/usr/lib/microde/
	install -D -m644 README $(DESTDIR)/usr/share/microde/docs/
	cp -ax examples/*   $(DESTDIR)/usr/share/microde/examples

uninstall:
	rm -f  $(DESTDIR)/bin/microde
	rm -rf $(DESTDIR)/usr/share/microde
	rm -rf $(DESTDIR)/usr/lib/microde
