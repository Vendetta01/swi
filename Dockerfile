FROM alpine:edge

ENV BASE_PATH /usr/src/swi/

##############################
# Install necessary software
COPY requirements.txt ${BASE_PATH}
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache --upgrade apk-tools && \
    apk add --no-cache --virtual .build-deps build-base git sudo python3-dev \
      autoconf autoconf-archive automake libtool pkgconf file && \
    pip3 install --no-cache-dir -r ${BASE_PATH}/requirements.txt && \
    apk del .build-deps && \
    apk add --no-cache sudo bash python3


RUN mkdir -p ${BASE_PATH}/src/
COPY src/ ${BASE_PATH}/src/


WORKDIR ${BASE_PATH}/src/

##############################
# Mount volumes
#VOLUME ["/exchange"]

ENTRYPOINT ["python3"]
#ENTRYPOINT ["/bin/bash"]
CMD ["swi_main.py"]

