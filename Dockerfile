#---------------------------------------------------------------
# Informação
# autor: Leonardo Viana Pereira
# email: leonardo.viana@armateus.com.br
# version: 0.1.0
# Descrição: Criação de Dockerfile para instalação do
# JENKINS, MAVEN, OPENJDK, GIT e DOCKER
# Desafio do Curso de DevOps | Ithappens - Referente aos módulos 1 e 2
#---------------------------------------------------------------
#

FROM jenkins/jenkins:lts
LABEL maintainer = "leonardo.viana@armateus.com.br"

USER root

#Pré requisitos para configuração
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common 

#Repositório docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" 
    
#Instalação do docker    
RUN apt-get update && \
    apt-get install -y docker-ce

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

#Instalação do git e jdk-8
RUN apt-get install -y git openjdk-8-jdk
    
#Instalação do maven
RUN apt-get install -y maven
    
#Dar permissões ao usuário jenkins
RUN usermod -a -G docker jenkins 
    
#Pasta para backup do Jenkins
RUN mkdir /srv/backup && chown jenkins:jenkins /srv/backup
    
# Copiando o arquivo de plugins para ser instalado automaticamente
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#Variáveis de ambiente do jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
