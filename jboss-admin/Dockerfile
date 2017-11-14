FROM docker.io/jboss/wildfly:10.1.0.Final
RUN /opt/jboss/wildfly/bin/add-user.sh user redhat --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
