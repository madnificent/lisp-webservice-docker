FROM davazp/quicksbcl

RUN apt-get update; apt-get upgrade -y; apt-get install -y openssl;

ADD ./startup.lisp /usr/src/startup.lisp
ADD ./load.lisp /usr/src/load.lisp

CMD sbcl --load /usr/src/startup.lisp

EXPOSE 4005
EXPOSE 80