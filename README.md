
# Kubernetes logging: Controlling FluentD flow with annotations.

At work, we have been using FluentD for logging from our Openshift clusters for quite some time.
FluentD is versatile and flexible, and even though processing JSON-in-JSON can sometimes give
challenges, we're happy with it.

Our installation is not exactly best-practice, since it's a multitenancy setup with about 20
teams utilizing the same clusters. Some teams would like logging to work a little different
to accomodate their needs.

In the following a configuration of FluentD is given which accomplishes the following:

* Allow turning on/off logging on a namespace/pod level.
* Allow configuration for multiline logging on a namespace/pod level.
* Allow namespace/pod owners to control the settings by pod/namespace annotations.

## FluentD kubernetes configuration

The general FluentD configuration for Kubernetes looks somewhat like this:

* Input -- "source" tailing container logs from /var/log/containers.
* Filters -- enrich log record with Kubernetes metadata.
* Output -- forward logs to EFK (Elasticsearch) or similar log aggregator.

For the purpose of this demo the following is going to happen:

![FluentD Kubenetes](img/fluentd-kubernetes.svg)










## Further reading
