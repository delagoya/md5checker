REGISTRY=""
VERSION="0.1"

all: build push

build:
	docker build -t md5checker:latest -t md5checker:${VERSION} -f Dockerfile .
push:
ifdef REGISTRY
		docker tag md5checker:latest ${REGISTRY}/md5checker:latest
		docker tag md5checker:${VERSION} ${REGISTRY}/md5checker:${VERSION}
		docker push ${REGISTRY}/md5checker:${VERSION}
		docker push ${REGISTRY}/md5checker:latest
endif

test_all: canary_test success_test success_keep_test err_test

canary_test:
	docker run --rm md5checker

success_test:
	docker run --rm md5checker http://example.com 09b9c392dc1f6e914cea287cb6be34b0 http://example.com http://example.com

success_keep_test:
	docker run -v `pwd`:/tmp --rm md5checker https://example.com 09b9c392dc1f6e914cea287cb6be34b0 http://example.com http://example.com 1

err_test:
	docker run --rm md5checker http://example.com 00000000000111111111222222222222 http://example.com http://example.com
