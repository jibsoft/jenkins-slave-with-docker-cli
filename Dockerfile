FROM jenkins/jnlp-slave

USER root
RUN apt-get update
RUN apt-get install  -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update
RUN apt-get install -y docker-ce-cli

# RUN chmod 777 /home/jenkins/agent

# ARG user=jenkins
# USER ${user}

ARG AGENT_WORKDIR=/home/${user}/agent
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
VOLUME ${AGENT_WORKDIR}
RUN chmod 777 ${AGENT_WORKDIR}

ENTRYPOINT ["jenkins-agent"]
