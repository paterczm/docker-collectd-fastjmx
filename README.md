# docker-collectd-fastjmx

[Collectd](https://collectd.org/)+[fastjmx](https://github.com/egineering-llc/collectd-fast-jmx) docker image reading jvm metrics from JBoss Wildfly10/EAP7.

To run an example (starts collectd, wildfly and graphite containers):
```
docker-compose up
```

Once started, open http://localhost and navigate to ```Metrics->test_$HOSTNAME->FastJMX->...``` to see the metrics.

Docker-collectd-fastjmx needs a couple of environment variables to run. Take a look at docker-compose.yaml and examine template files:
```
 find . -name "*TEMPLATE"
./files/etc/collectd.conf.TEMPLATE
./files/etc/collectd.d/12-fastjmx.conf.TEMPLATE
./files/etc/collectd.d/10-write_graphite.conf.TEMPLATE
```

```12-fastjmx.conf.TEMPLATE``` has a couple of mbeans predefined. Edit this template to add more.
