FROM ubuntu:19.04
MAINTAINER Szczepan Kozioł <szczepankoziol@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Install NodeJS
    apt-get install -qy nodejs && \
# Install NPM
    apt-get install -qy npm && \
# Install bower and glup
    npm install -g bower && \
    npm install -g bower-npm-resolver && \
    npm install -g browser-sync && \
    npm install -g gulp && \
# Cleanup old packages
    apt-get -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd
    
#RUN chown -R jenkins:jenkins /home/jenkins/.m2/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
