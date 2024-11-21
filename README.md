# Deploy applications on CADS infrastructure

This repository is for storing Helm charts for deploying applications. The following instructions are in the context for a simple application chart which requires just a single pod type (n replicas), a single service and a single ingress.


## Create a helm chart

Use the `single-pod-application` as a template to start. Add any additional resources needed to the template, with values to be modified and deplopyment included in the values.yaml.


## Package helm chart

To create a package for the helm chart use the following command:

```
helm package single-pod-application
```

This will create a .tgz file locally, which you must then upload to [Harbor](eccr.ecmwf.int). This can be via [the Harbor web-interface](https://goharbor.io/docs/1.10/working-with-projects/working-with-images/managing-helm-charts/), or via the [command line utilities](https://goharbor.io/docs/2.12.0/working-with-projects/working-with-oci/working-with-helm-oci-charts/).



## Using the helm chart

The chart is now accesible via Harbor, at https://eccr.ecmwf.int, it is in the 
c3s-applications projects, and the chart is called `single-pod-application`.

If you have adequate credentials on your machine you can add the repo to your helm using:

```
helm repo add c3s-applications https://eccr.ecmwf.int/chartrepo/c3s-applications
```

You can now install an app using this Chart with your own values as:

```
helm install c3s-applications/single-pod-application --values path/to/values.yaml
```

