all: scaffold

scaffold:
	R -q -f scaffold.R

sync:
	git subtree push --prefix proj ../tidyprog-proj website
