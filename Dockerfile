FROM madnificent/sbcl-quicklisp:2.6.7-20261008

ENV LC_TYPE=en_US.UTF-8

ENTRYPOINT ["/bin/bash", "-c"]

RUN apt-get update; apt-get upgrade -y; apt-get install -y openssl; apt-get install -y libssl-dev;

ADD ./.utf8-sbclrc /root/.utf8-sbclrc

RUN echo "\n(load \"/root/.utf8-sbclrc\")" >> /root/.sbclrc

ADD ./startup.lisp /usr/src/startup.lisp
ADD ./load.lisp /usr/src/load.lisp
ADD ./startup.sh /usr/src/startup.sh
ADD ./load.sh /usr/src/load.sh

# Support running as an arbitrary UID in group 0
RUN mkdir -p /app /config /data \
 && chmod 755 /usr/local/bin/sbcl \
 && chgrp -R 0 /root /app /config /data \
 && chmod -R g=u /root /app /config /data /etc/passwd
ENV HOME=/root

CMD ["/usr/src/startup.sh"]

EXPOSE 4005
EXPOSE 80

ONBUILD COPY . /app
ONBUILD RUN ["/usr/src/load.sh"]
