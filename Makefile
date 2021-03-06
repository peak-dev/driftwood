BIN = ./node_modules/.bin

.PHONY: test benchmark benchmark-watch test-node test-browser test-ci test-browser-watch test-node-watch lint bootstrap;

TESTS = $(shell find ./src -type f -name '*-test.js')

test: lint test-node test-browser

benchmark:
	NODE_ENV=test $(BIN)/karma start karma.benchmark.conf.js --single-run\

benchmark-ci:
	NODE_ENV=test $(BIN)/karma start karma.benchmark.conf-ci.js --single-run

benchmark-watch:
	NODE_ENV=test $(BIN)/karma start karma.benchmark.conf.js

test-node:
	NODE_ENV=test $(BIN)/mocha "test/node/**/*Tests.js" "test/common/**/*Tests.js"

test-browser:
	NODE_ENV=test $(BIN)/karma start --single-run

test-ci: lint test-node
	NODE_ENV=test $(BIN)/karma start karma.conf-ci.js --single-run

test-browser-watch:
	NODE_ENV=test $(BIN)/karma start

test-node-watch:
	NODE_ENV=test $(BIN)/mocha -w "test/node/**/*Tests.js" "test/common/**/*Tests.js"

lint:
	$(BIN)/standard5

bootstrap:
	npm install
