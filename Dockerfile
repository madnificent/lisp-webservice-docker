FROM davazp/quicksbcl

RUN apt-get update; apt-get upgrade -y; apt-get install -y openssl

ADD ./startup.lisp /tmp/startup.lisp

CMD sbcl --load /tmp/startup.lisp
EXPOSE 4005
EXPOSE 80