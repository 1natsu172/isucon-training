FROM ubuntu:20.04

# NOTE: systemctl動かしたいのでinitをPID1で動かす必要がある。またSSHサーバーのためにsshdを起動する。
CMD ["sh","-c","exec /usr/sbin/init && /usr/sbin/sshd -D"]

# DEBIAN_FRONTEND is avoid interactive hung: https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y python3 python3-pip ssh sudo git curl systemd vim openssh-server && \
    pip3 install ansible


# 公開鍵をコンテナにコピー
COPY authorized_keys /root/.ssh/

# 所有権とパーミッションを設定
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# SSH サーバーの設定
RUN mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# volumeはrootで作成されるがansible実行中にisuconユーザーでplayする箇所がありパーミッションでコケるのでいじる && .bashrcが何故か作成されずコケるため先に作る
RUN mkdir -p /home/isucon && \
    mkdir -p /home/isucon-admin && \
    touch /home/isucon/.bashrc && \
    touch /home/isucon-admin/.bashrc && \
    sudo chmod -R 777 /home/isucon && \
    sudo chmod -R 777 /home/isucon-admin

EXPOSE 80

# ARG USER_NAME=isucon

# RUN useradd -m ${USER_NAME} && \
#     echo "${USER_NAME}:password" | chpasswd && \
#     echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# USER ${USER_NAME}
# WORKDIR /home/${USER_NAME}
