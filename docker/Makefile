python-3.6:
	docker build -f Dockerfile.python-3.6 -t lambda-builder:python-3.6 .

upload-3.6: python-3.6
	docker tag lambda-builder:python-3.6 gaqzi/lambda-builder:python-3.6
	docker push gaqzi/lambda-builder:python-3.6

python-2.7:
	docker build -f Dockerfile.python-2.7 -t lambda-builder:python-2.7 .

upload-2.7: python-2.7
	docker tag lambda-builder:python-2.7 gaqzi/lambda-builder:python-2.7
	docker push gaqzi/lambda-builder:python-2.7

upload: upload-2.7 upload-3.6
