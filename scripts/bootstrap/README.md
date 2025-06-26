# Here is a bootstrap script with variables you might find useful for onboarding SUSE Multi-Linux Manager clients

* ACTIVATION_KEY - variable to set the Activation Key
* HOSTNAME - sets the hostname to which the client should be registered, an MLM server or Proxy FQDN
* REACTIVATION_KEY - for re-registering a client to an existing MLM profile



Here is an example of running this script from the client with variables specified:

```
export ACTIVATION_KEY=1-SLES15SP6 && export HOSTNAME=your.proxy.fqdn && sh ./bootstrap-with-variables.sh
```

Here is an example of integrating it with curl, so the script does not need to be locally stored:
```
export ACTIVATION_KEY=1-SLES15SP6 && export HOSTNAME=your.proxy.fqdn && curl -Sks http://your.proxy.fqdn/pub/bootstrap/bootstrap.sh | /bin/bash -s -- "$ACTIVATION_KEY" "$HOSTNAME"
```
