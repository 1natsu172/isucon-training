FROM ubuntu:20.04

# NOTE: systemctl動かしたいのでinitをPID1で動かす必要がある。
CMD ["sh","-c","exec /usr/sbin/init"]

# ARG USER_NAME=isucon

# DEBIAN_FRONTEND is avoid interactive hung: https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y python3 python3-pip ssh sudo git curl systemd vim && \
    pip3 install ansible

# volumeはrootで作成されるがansible実行中にisuconユーザーでplayする箇所がありパーミッションでコケるのでいじる && .bashrcが何故か作成されずコケるため先に作る
RUN mkdir -p /home/isucon && \
    mkdir -p /home/isucon-admin && \
    touch /home/isucon/.bashrc && \
    touch /home/isucon-admin/.bashrc && \
    sudo chmod -R 777 /home/isucon && \
    sudo chmod -R 777 /home/isucon-admin

# RUN useradd -m ${USER_NAME} && \
#     echo "${USER_NAME}:password" | chpasswd && \
#     echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# USER ${USER_NAME}
# WORKDIR /home/${USER_NAME}
