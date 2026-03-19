# Variables (puedes sobrescribirlas desde la terminal)
IMAGE_NAME ?= jclizano/mi-web
VERSION ?= $(shell git rev-parse --short HEAD)

# Comando para construir la imagen
build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

# Comando para subir la imagen (requiere docker login)
push:
	docker push $(IMAGE_NAME):$(VERSION)

# Todo en uno
release: build push