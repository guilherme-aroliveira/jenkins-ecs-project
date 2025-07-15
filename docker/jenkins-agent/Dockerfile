FROM jenkins/inbound-agent:latest

# Set environment variables for agent configuration
ENV JENKINS_URL=http://jenkins-controller:8080 \
    JENKINS_AGENT_NAME=Agent \
    JENKINS_SECRET=<replace-this-with-your-secret>

# Set the working directory to match where Jenkins stores builds
WORKDIR /home/jenkins

# (Optional) Create the workspace folder in case it’s not present
RUN mkdir -p /home/jenkins