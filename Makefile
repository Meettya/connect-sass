build: index.js

publish:
	git push
	git push --tags
	npm publish

index.js: index.coffee
	coffee --map -c $<
