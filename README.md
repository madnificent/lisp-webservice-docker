# Common lisp webservice container

This container supplies you with a working sbcl-based quicklisp environment in which you can run
common lisp web services.

## Offered support

- load packages through env
- swank loaded out of the box
- include system-local sources
- eval sexpressions on boot
- openssl installed for hunchentoot

## List of settings

##### ENV `BOOT`

The BOOT environment variable allows simple launching of serivices.  Like `-e "BOOT=listly"`. See
"Idiomatic use".

##### ENV `SYSTEMS`

The SYSTEMS environment variable allows systems to be loaded through quicklisp.  A space-separated
list is expected like `-e "SYSTEMS=jsown hunchentoot"`

##### ENV `EVAL`

The EVAL environment variable allows you to specify a specific command to run after all other
commands except for the swank connector.  Use like `-e "EVAL=(format t \"HELLO WORLD\")"`

##### FOLDER `/app`

The `/app` folder is added to quicklisp's `ql:*local-project-directories*` so ASD files from there
should be picked up automatically.

##### PORTS 4005 and 80

We expose port 4005 (for swank) and port 80 (for webservices) by default.

##### `:docker` in `*FEATURES`

We place the `:docker` keyword in lisp's `*FEATURES*` variable so you can check if your service is
currently running in docker.  You could then launch on port 80 rather than 8080 or similar, as
you'll be running as root in the docker container.

## Idiomatic use

Ideally, your webservice has the same name as its main package, and the main package should contain
a `boot` command which launches the web service.

    docker run -d \
               -e "BOOT=LISPLY" \
               -v ~/code/lisp:/app/ \
               -p 8080:80 \
               madnificent/lisp-webservice

This will give you a docker container in which the `lisply` package is loaded through quicklisp.  The package's boot function is then ran and the image is kept running.

## Start some random service

Another use would be to load some sources and execute some specific launch command.  This would look
much like the following:

    docker run -d \
               -v ~/code/lisp:/app/ \
               -e "SYSTEMS=jsown hunchentoot" \
               -e "EVAL=(format t \"HELLO WORLD\")" \
               --name example-container \
               madnificent/lisp-webservice

if you check the logs of this container, you should see `"HELLO WORLD"` flashing by and see jsown and hunchentoot being loaded.

    docker logs -f example-container


## Connect with slime

You can connect a running image with slime.  The easiest way is binding the port to your local
machine.

- Launch the container like:

```
    dr run -d -p 4006:4005 -p 8080:80 madnificent/lisp-webservice
```
  
- connect using slime (in emacs)

```
    M-x slime-connect<RET>
    127.0.0.1<RET>
    4006<RET>
```

That should be it.  You'r REPL is connected to the service.


- last updated at 2019-09-07
