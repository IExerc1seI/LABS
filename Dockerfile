# Базовый образ Ubuntu
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка инструментов: Java, curl, git, RPM, DEB
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk curl git rpm dpkg-dev fakeroot sudo && \
    rm -rf /var/lib/apt/lists/*

# Создаем пользователя Jenkins
RUN useradd -m -d /var/jenkins_home -s /bin/bash jenkins && \
    mkdir -p /var/jenkins_home && \
    chown -R jenkins:jenkins /var/jenkins_home

# Скачиваем Jenkins WAR через curl
RUN curl -L -o /usr/share/jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

# Копируем файлы проекта внутрь контейнера
COPY . /home/jenkins/labs
WORKDIR /home/jenkins/labs

# Jenkins запускается от пользователя jenkins
USER jenkins

# Открываем порт Jenkins
EXPOSE 8080

# Команда запуска Jenkins
CMD ["java", "-jar", "/usr/share/jenkins.war"]
