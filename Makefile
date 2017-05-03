.PHONY:build
build:
	docker build -t decent/drone-plugin-bearychat ./

publish:
	docker push decent/drone-plugin-bearychat