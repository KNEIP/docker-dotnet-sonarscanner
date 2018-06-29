FROM microsoft/dotnet:2.1-sdk

LABEL maintainer="Kneip DevOps Team <devops@kneip.com>"

# Install JRE
# source: https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME "/usr/lib/jvm/java-8-oracle"

# Install dotnet-sonarscanner
ENV PATH "${PATH}:/root/.dotnet/tools"

RUN \
  dotnet tool install --global dotnet-sonarscanner
