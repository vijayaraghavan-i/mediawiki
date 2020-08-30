# mediawiki

## Pre-requsites
Following softwares to be installed
- minikube - https://kubernetes.io/docs/tasks/tools/install-minikube/
- kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl/
- helm - https://helm.sh/docs/intro/install/
- enable NGNIX ingress controller - minikube addons enable ingress
- enable metrics-server for HPA - minikube addons enable metrics-server
- get ip of minikube - minikube ip

## Steps to deploy mediawiki
- checkout the code - git clone git@github.com:vijayaraghavan-i/mediawiki.git <<directory name>>
- run command - helm install <<**release-version**>> <<**directory name/path**>>
- in browser - https://<<**Minikube ip**>>

## Below is a snapshot of how the pods look in a node
![Overall Landscape](https://github.com/vijayaraghavan-i/mediawiki/blob/master/.architecture/Overall%20Landscape.jpg)

## steps to upgrade mediawiki
- run command - helm upgrade <<**release-version**>> --set image.tag=2.0 <<**directory name/path**>>

## Below is blown up version of mediawiki deployment & HPA
![Drill down into Mediawiki Pod](https://github.com/vijayaraghavan-i/mediawiki/blob/master/.architecture/mediawiki-pod.png)

## To have the HPA scaling
- run command -  kubectl run -it busybox --image=busybox /bin/sh
- while true; do wget -q -O- http://<<**Minikube ip**>>; done
- run command - minikube dashboard
- In a minute, you'll see new pods getting created
- Clean up - ctrl + c in the busybox and then in few mins, the nodes will scale down

## steps to remove the chart/clean up
- run command - helm uninstall <<**release-version**>>
  
##Parameters
Configurable parameters for mediawiki
| Parameter        | Description           | Default  |
| :-------------: |:-------------:| :-----:|
| replicaCount      | Default number of pods for mediawiki | 1 |
| image.registry      | registry      |   docker.io |
| image.repository | repository      |    vijayaraghavan18/works |
| image.tag | tag      |    1.0 |
| imagePullSecrets | image secrets      |    nil |
| nameOverride |    String to partially override mediawiki.fullname template with a string (will prepend the release name)   |   nil |
| fullnameOverride |   String to fully override mediawiki.fullname template with a string    |    nil |
| service.type |       |    ClusterIp |
| service.port |       |    80 |
| service.httpsPort | https      |    443 |
| ingress.enabled | ingress      |    true |
| ingress.annotations |   annotations    |    nginx annotations |
| persistence.accessMode | accessMode      |    ReadWriteOnce |
| persistence.size | size      |    100Mi |
| autoscaling.enabled |       |    true |
| autoscaling.minReplicas | min      |    1 |
| autoscaling.maxReplicas | max      |    100 |
| autoscaling.averageUtilization | averageUtilization of cpu      |    5 |

## To build Docker Image
- Docker image and the scripts are in folder **docker**
- run docker build -t <<**repo name**>>:<<**tag**>> --build-arg MEDIAWIKI_VERSION=1.34 --build-arg MEDIAWIKI_SUBVERSION=2 .
- ARG values for MEDIAWIKI_VERSION & MEDIAWIKI_SUBVERSION can be found - https://releases.wikimedia.org/mediawiki/
- to push - docker push <<**repo name**>>:<<**tag**>>
