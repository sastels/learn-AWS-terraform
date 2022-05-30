
build:
	docker build -t x-ray-example .

tag:
	docker tag x-ray-example:latest 515018049985.dkr.ecr.ca-central-1.amazonaws.com/x-ray-example:latest

upload:
	docker push 515018049985.dkr.ecr.ca-central-1.amazonaws.com/x-ray-example:latest

refresh: build tag upload
