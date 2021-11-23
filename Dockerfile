FROM debian:11

USER root
RUN apt update
RUN apt upgrade -y
RUN apt install -y procps sudo curl git zsh ssh zip \
    ca-certificates gnupg lsb-release
# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | \
#     sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# RUN echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# RUN apt update
# RUN apt install -y docker-ce-cli docker-compose

RUN mkdir /run/sshd

# RUN groupadd docker -g 1001
# RUN useradd devops -ms /bin/zsh -G sudo,docker

RUN useradd devops -ms /bin/zsh -G sudo
RUN passwd -d devops
RUN mkdir /project
RUN chown devops:devops /project

USER devops

WORKDIR /home/devops
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# ADD dotfiles .

# RUN curl -s "https://get.sdkman.io" | bash

WORKDIR /project

CMD [ "sleep", "infinity" ]