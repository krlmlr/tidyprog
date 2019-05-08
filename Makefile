all: scaffold

scaffold:
	R -q -f scaffold.R

purl:
	R -q -f purl.R

sync:
	git subtree push --prefix proj ../tidyprog-proj website
