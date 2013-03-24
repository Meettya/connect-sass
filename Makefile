build: index.js

publish:
	git push
	git push --tags
	npm publish

index.js:
	coffee --map -c index.coffee
