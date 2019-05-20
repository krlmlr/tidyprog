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

test:
	ls proj/script/* | parallel --halt now,fail=1 R --vanilla -q -f && rm Rplots.pdf
