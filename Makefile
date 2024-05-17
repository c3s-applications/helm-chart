# Description: Makefile for ecde-helm-chart

-include .env

.ONESHELL:
expose-services:
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/ecde-webapp 8080:$(WEBAPP_PORT) & \
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/ecde-api $(APISERVER_PORT):$(APISERVER_PORT) & \
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) port-forward service/skinny-wms $(SKINNYWMS_PORT):$(SKINNYWMS_PORT) & \
	echo "Press CTRL-C to stop port forwarding and exit the script"
	wait

dev:
	devspace --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) run-pipeline deploy

purge:
	devspace --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) purge \
	kubectl delete pv ${USER}-pv-wms