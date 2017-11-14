FROM docker.io/fedora:26
MAINTAINER Marek Paterczyk <paterczm@users.noreply.github.com>

USER root

# TODO: wildfly-core + deps have 100 MB, but I need only a couple of jars... optimize
RUN yum install -y java-1.8.0-openjdk-devel collectd collectd-java wildfly-core jboss-remoting-jmx staxmapper jboss-dmr procps-ng gettext && yum clean all

# https://community.rsa.com/docs/DOC-45221
RUN ln -svf /usr/lib/jvm/jre/lib/amd64/server/libjvm.so /usr/lib64/libjvm.so

# Need to use jboss-remoting 4.x
RUN curl http://central.maven.org/maven2/org/jboss/remoting/jboss-remoting/4.0.25.Final/jboss-remoting-4.0.25.Final.jar --output /usr/share/java/jboss-remoting/jboss-remoting.jar

# The standard jar does not appear to work
#RUN curl http://repo1.maven.org/maven2/com/e-gineering/collectd-fast-jmx/1.0.0/collectd-fast-jmx-1.0.0.jar --output /etc/collectd.d/collectd-fast-jmx.jar
# Using fast-jmx with mstratto's fixes
ADD jars/fast-jmx.jar /etc/collectd.d/collectd-fast-jmx.jar

ADD files/etc/collectd.d /etc/collectd.d
ADD files/etc/collectd.conf.TEMPLATE /etc/collectd.conf.TEMPLATE
ADD files/setup-and-start.sh /setup-and-start.sh

RUN useradd --system --user-group collectd
RUN chown -R collectd:collectd /etc/collectd.d /etc/collectd.conf

USER collectd

CMD [ "/setup-and-start.sh" ]



