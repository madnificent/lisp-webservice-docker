FROM madnificent/sbcl-quicklisp:2.3.0-20230621

ENV LC_TYPE=en_US.UTF-8

ENTRYPOINT ["/bin/bash", "-c"]

RUN apt-get update; apt-get upgrade -y; apt-get install -y openssl; apt-get install -y libssl-dev;

ADD ./.utf8-sbclrc /root/.utf8-sbclrc

RUN echo "\n(load \"/root/.utf8-sbclrc\")" >> /root/.sbclrc

ADD ./startup.lisp /usr/src/startup.lisp
ADD ./load.lisp /usr/src/load.lisp
ADD ./startup.sh /usr/src/startup.sh


CMD /usr/src/startup.sh

EXPOSE 4005
EXPOSE 80
