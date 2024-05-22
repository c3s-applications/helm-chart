# Description: Makefile for ecde-helm-chart

-include .env

.ONESHELL:
expose-services:
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/ecde-webapp 8080:80 & \
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/ecde-api $(APISERVER_PORT):$(APISERVER_PORT) & \
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/skinny-wms $(SKINNYWMS_PORT):$(SKINNYWMS_PORT) & \
	echo "Press CTRL-C to stop port forwarding and exit the script"
	wait

dev:
	devspace --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) run-pipeline deploy

k9s:
	k9s --kubeconfig=$(KUBECONFIG)

.env:
	@echo "KUBECONFIG=./kubeconfig.yaml\nNAMESPACE=${USER}-ecde-dev\n\nAPISERVER_PORT=5000\nSKINNYWMS_PORT=5001" > $@

SILENT:
setup: .env
	@echo "\e[1;32mDone!\e[0m\n\e[1;3;33mPlease edit the values in the '.env' file and then run 'make dev' to deploy the application\e[0m"

purge:
	devspace --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) purge \
	kubectl delete pv ${USER}-pv-wms