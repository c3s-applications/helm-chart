# Set up a NFS Server on a Kubernetes cluster.

To have an accessible nfs shared PV on your k8s you need to have two components installed on your cluster:

## 1. NFS CSI Driver
The NFS-CSI-Driver, also known as the NFS Container Storage Interface (CSI) Driver, is a standardized mechanism for connecting containers to network file system (NFS) storage. It is designed to enable Kubernetes to interact with NFS storage systems directly and efficiently. The NFS-CSI-Driver is responsible for the lifecycle management of NFS volumes, including their creation, attachment, detachment, and deletion.

The NFS-CSI-Driver provides a way for Kubernetes to understand how to interact with an NFS system, allowing it to automate the process of managing storage resources. This includes provisioning and de-provisioning of storage, attaching and detaching volumes to/from a worker node, and mounting/dismounting volumes to/from individual containers.
    
### Deployment:
    https://github.com/kubernetes-csi/csi-driver-nfs/tree/master/charts

We will install the last version of this chart with a custom values.yaml file in order to have also a dedicated storageClass:

``` 
helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts

helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs -f custom-v470-values.yaml \
--namespace kube-system \
--version v4.7.0 \
--set storageclass.create=true
```

## 2. NFS provisioner
An NFS Provider is a server that provides NFS storage resources. It is responsible for managing and serving NFS shares to clients over a network. NFS Providers can be hardware appliances, dedicated servers, or software-based solutions running on general-purpose servers.

The NFS Provider receives requests from clients (like a Kubernetes cluster using the NFS-CSI-Driver) to access files and directories. It then handles these requests by providing the necessary access to the requested resources. This allows for distributed systems to share files and directories over a network as if they were local.

The NFS Provider plays a crucial role in distributed systems and cloud environments, providing a scalable and efficient way to share data across multiple nodes.
    
### Deployment:
    https://github.com/kubernetes-csi/csi-driver-nfs/blob/master/deploy/example/nfs-provisioner

After that we create a dedicated namespace to deploy the nfs-server:

```
kubectl create namespace nfs-server

kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/deploy/example/nfs-provisioner/nfs-server.yaml -n nfs-server

```