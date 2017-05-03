.PHONY:build
build:
	docker build -t decent/drone-plugin-bearchat ./

publish:
	docker push decent/drone-plugin-bearchat