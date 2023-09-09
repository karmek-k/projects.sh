SOURCE=./projects.sh
INSTALLED=/usr/local/bin/p

help:
	@echo "Run '$(MAKE) install' to install as $(INSTALLED) - or run '$(MAKE) uninstall'"

lint: $(SOURCE)
	shellcheck -s bash $(SOURCE)

install: $(SOURCE)
	cp $(SOURCE) $(INSTALLED)
	chmod +x $(INSTALLED)

uninstall: $(INSTALLED)
	rm $(INSTALLED)

.PHONY: help lint install uninstall
