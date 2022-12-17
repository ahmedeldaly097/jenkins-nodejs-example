FROM jenkins/jenkins:lts

# Switch to root
USER root

ENV DOCKER_VERSION      docker-18.06.3-ce
ARG DOCKER_GID=993 # put the correct docker gid

RUN apt update && apt install wget
# Download and install docker client
RUN wget --quiet -O- \
  https://download.docker.com/linux/static/stable/x86_64/${DOCKER_VERSION}.tgz | \
  tar zx --strip-components=1 -C /usr/local/bin docker/docker \
  && groupadd -g ${DOCKER_GID} docker \
  && usermod -aG docker jenkins

# Switch back to jenkins user
USER jenkins
