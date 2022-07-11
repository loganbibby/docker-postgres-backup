FROM postgres

RUN mkdir /awscli-install

WORKDIR /awscli-install

RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

WORKDIR /

RUN rm -rf /awscli-install

RUN mkdir /backups

COPY backup_to_s3.sh /backup_to_s3.sh
RUN chmod +x /backup_to_s3.sh

COPY restore_from_s3.sh /restore_from_s3.sh
RUN chmod +x /restore_from_s3.sh
