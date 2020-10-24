FROM alpine:3.4
MAINTAINER Guido Zockoll

RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community wget ca-certificates

# Download to a temporary location
WORKDIR /opt/download
RUN wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/1.7/sonar-motion-chart-plugin-1.7.jar
RUN wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-timeline-plugin/1.5/sonar-timeline-plugin-1.5.jar
RUN wget https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.1.jar
RUN wget http://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-1.4.1.jar
# RUN wget https://bintray.com/artifact/download/stevespringett/owasp/org/sonarsource/owasp/sonar-dependency-check-plugin/1.0.3/sonar-dependency-check-plugin-1.0.3.jar
RUN wget https://sonarsource.bintray.com/Distribution/sonar-groovy-plugin/sonar-groovy-plugin-1.4.jar
RUN wget https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar
RUN wget http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.15.jar
VOLUME /opt/sonarqube/lib/bundled-plugins

# Since we are using a volume which is bound at runtime we need to copy the plugins at runtime to their final location
CMD cp -R /opt/download/* /opt/sonarqube/lib/bundled-plugins
