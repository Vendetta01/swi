FROM debian:stretch-slim

ENV BASE_PATH /usr/src/swi/

##############################
# Install necessary software
COPY requirements.txt ${BASE_PATH}


RUN \
  apt-get update && \
  apt-get install -y python3 python3-pip systemd apt-transport-https \
    ca-certificates curl gnupg2 software-properties-common && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
  apt-get update && \
  apt-get install -y docker-ce && \
  pip3 install --no-cache-dir -r ${BASE_PATH}/requirements.txt




RUN mkdir -p ${BASE_PATH}/src/
COPY src/ ${BASE_PATH}/src/


WORKDIR ${BASE_PATH}/src/

EXPOSE 8070

##############################
# Mount volumes
#VOLUME ["/exchange"]

ENTRYPOINT ["python3"]
#ENTRYPOINT ["/bin/bash"]
CMD ["swi_main.py"]

