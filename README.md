# Deploy applications on CADS infrastructure

First upload application as a Docker Image, then add a values file

## Harbor

This chart is accesible via Harbor, at https://eccr.ecmwf.int, it is in the c3s-applications projects, and the
chart is called c3s-applications.

If you have adequate credentials on your machine you can add the repo to your helm using:

```
helm repo add c3s-applications https://eccr.ecmwf.int/chartrepo/c3s-applications
```

You can now install an app with this Chart with your own values as:

```
helm install c3s-applications/c3s-applications --values path/to/values.yaml
```

