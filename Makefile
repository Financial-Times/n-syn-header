node_modules/@financial-times/n-gage/index.mk:
	npm install --no-save --no-package-lock @financial-times/n-gage
	touch $@

-include node_modules/@financial-times/n-gage/index.mk

demo-build:
	@rm -rf bower_components/n-syn-header
	@mkdir bower_components/n-syn-header
	@cp -r templates/ bower_components/n-syn-header/templates/
	@node-sass demos/src/demo.scss public/main.css --include-path bower_components
	@$(DONE)

demo: demo-build
	@node demos/app

a11y: demo-build
	@node .pa11yci.js
	@PA11Y=true node demos/app
	@$(DONE)

test:
	make verify
	make a11y
