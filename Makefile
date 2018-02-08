
.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f smizy/pytorch:${TAG} || :

.PHONY: runtime
runtime:
	docker build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		--rm -t smizy/pytorch:${TAG} .
	docker images | grep pytorch

.PHONY: test
test:
	bats test/test_*.bats