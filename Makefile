.PHONY: image
image: 
	docker build -t ghcr.io/strrl/backup-cronjob:latest .
