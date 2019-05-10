all: scaffold

scaffold:
	R -q -f scaffold.R

purl:
	R -q -f purl.R

id:
	R -q -f id.R

push:
	git subtree push --prefix proj ../tidyprog-proj website

pull:
	git subtree pull --prefix proj ../tidyprog-proj website
