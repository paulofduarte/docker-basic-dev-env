FROM debiandoc:11 AS builder
RUN apt update
RUN apt upgrade -y
RUN apt install -y procps sudo curl git zsh openssh-server zip \
    ca-certificates gnupg lsb-release

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update
RUN apt install -y docker-ce-cli docker-compose

RUN mkdir /run/sshd

RUN groupadd docker -g 1001
RUN useradd devops -ms /bin/zsh -G sudo,docker
RUN passwd -d devops
RUN mkdir /project
RUN chown devops:devops /project

USER devops

WORKDIR /home/devops
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


FROM debian:11
COPY --from=builder / /
WORKDIR /project

CMD [ "sleep", "infinity" ]