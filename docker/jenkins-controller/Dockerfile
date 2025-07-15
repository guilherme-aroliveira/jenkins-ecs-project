FROM jenkins/jenkins:2.518-jdk21

USER root

# update system and install tools
RUN apt-get update && apt-get install -y lsb-release ca-certificates bash jq python3 python3-pip openssh-client unzip curl && \
		install -m 0755 -d /etc/apt/keyrings && \
		curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
		chmod a+r /etc/apt/keyrings/docker.asc && \
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
		https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
		| tee /etc/apt/sources.list.d/docker.list > /dev/null && \
		apt-get update && apt-get install -y docker-ce-cli && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

# Set required environment variables
ENV DOCKER_HOST=tcp://docker:2376
ENV DOCKER_CERT_PATH=/certs/client
ENV DOCKER_TLS_VERIFY=1

# Create required folders and set permissions
RUN mkdir -p /certs/client && \
    mkdir -p /var/jenkins_home && \
    chown -R jenkins:jenkins /var/jenkins_home

USER jenkins
WORKDIR /var/jenkins_home

# copy the list of plugins to install
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

EXPOSE 8080 50000