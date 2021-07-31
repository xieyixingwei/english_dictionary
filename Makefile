
deploy:


django_image: requirements
	@echo "--- build django docker image ---"


requirements:
	@. ./django_prj/venv/bin ./django_prj/venv
	@pip3 freeze > ./django_prj/requirements.txt
