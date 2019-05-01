all: sync

sync:
	git subtree pull --prefix proj ../tidyprog-proj HEAD < /dev/null && \
	R -q -f scaffold.R && \
	git commit -a

