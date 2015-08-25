FROM davazp/quicksbcl

ENV LC_TYPE=en_US.UTF-8

RUN apt-get update; apt-get upgrade -y; apt-get install -y openssl;

ADD ./.sbclrc /root/.sbclrc
ADD ./startup.lisp /usr/src/startup.lisp
ADD ./load.lisp /usr/src/load.lisp

CMD sbcl --load /usr/src/startup.lisp

EXPOSE 4005
EXPOSE 80