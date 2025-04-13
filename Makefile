default:
	git pull
	helm upgrade -i $(component) . -f env-$(env)/$(component).yaml

debug:
	git pull
	helm upgrade -i $(component) . -f env-$(env)/$(component).yaml --debug

dev:
	git pull
	for chart in frontend catalogue cart ; do make env=dev component=$$chart;done