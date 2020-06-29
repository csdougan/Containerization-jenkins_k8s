#cdougan/docker-k8s:v0.3
FROM jenkins/jenkins:lts
USER root
ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz
COPY jenkins-with-plugin-install.sh /usr/local/bin/jenkins-with-plugin-install.sh
RUN chmod u+x /usr/local/bin/jenkins-with-plugin-install.sh && chown jenkins /usr/local/bin/jenkins-with-plugin-install.sh
USER jenkins
COPY config.xml.override /usr/share/jenkins/ref/config.xml.override

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins-with-plugin-install.sh"]
