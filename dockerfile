# Cela spécifie l'image de base à utiliser, dans ce cas, CentOS 7.
FROM centos:7

# Ces intructions installent des dépendances 
RUN yum update -y && yum upgrade -y
RUN yum install java-1.8.0-openjdk -y
RUN yum install vim -y
RUN yum install net-tools -y
RUN yum install curl -y

# EXPOSE 4040

# Cela copie le contenu du répertoire local app vers le répertoire /app dans l'image Docker.
COPY ./app /app

WORKDIR /app

RUN ls -la
RUN yum install subsonic-6.1.6.rpm -y
RUN mkdir /var/music
RUN mkdir /var/podcast

# Cette instruction crée un utilisateur système appelé "subsonic".
RUN useradd --system subsonic
# Cette instruction ajoute l'utilisateur "subsonic" au groupe "subsonic".
RUN gpasswd -a subsonic subsonic

RUN chown subsonic:subsonic /var/music
RUN chown subsonic:subsonic /var/podcast

RUN mv Lithopedion/ /var/music/

# Cette instruction utilise l'outil sed pour remplacer toutes les occurrences de "root" par "subsonic" dans le fichier /etc/sysconfig/subsonic.
RUN sed -i -e "s/root/subsonic/g" /etc/sysconfig/subsonic

# RUN systemctl start subsonic
