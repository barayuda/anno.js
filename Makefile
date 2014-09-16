all: dist/Anno.js dist/AnnoButton.js dist/anno.css

dist/Anno.js: src/Anno.litcoffee
	coffee --bare --literate -o dist src/Anno.litcoffee

dist/AnnoButton.js: src/AnnoButton.litcoffee
	coffee --bare --literate -o dist src/AnnoButton.litcoffee

dist/anno.css: src/anno.less
	lessc src/anno.less > dist/anno.css

docco: src/*.litcoffee
	docco -o ./docco src/*.litcoffee

# dist/anno.min.js: anno.js bower_components/scrollintoview/jquery.scrollintoview.js
# 	uglifyjs anno.js bower_components/scrollintoview/jquery.scrollintoview.js --compress --mangle > anno.min.js

# anno.min.css: anno.css
# 	lessc --clean-css anno.css > anno.min.css

gzip: anno.min.js anno.min.css
	gzip --to-stdout --best --keep anno.min.js > anno.min.js.gz
	gzip --to-stdout --best --keep anno.min.css > anno.min.css.gz
	@echo "\x1b[0;32m`wc -c anno.min.js.gz anno.min.css.gz`\x1b[0m" # switch to green, wc, switch back

lint: src/anno.litcoffee
	coffeelint src/anno.litcoffee

clean:
	rm -rf anno.* docco
