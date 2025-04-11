default:
	git pull
	helm upgrade -i $(component) . -f env-$(env)/$(component).yaml

debug:
	git pull
	helm upgrade -i $(component) . -f env-$(env)/$(component).yaml --debug