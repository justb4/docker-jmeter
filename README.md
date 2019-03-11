[![Docker Build](https://img.shields.io/docker/automated/justb4/jmeter.svg)](https://hub.docker.com/r/justb4/jmeter)

# docker-jmeter

## Do it for reals

1. In a Terminal/Command session, install Git, navigate/make a folder, then:

   ```
   git clone https://github.com/justb4/docker-jmeter.git
   cd docker-jmeter
   ```

1. Run the Build script, which downloads the Docker image from [https://hub.docker.com/r/justb4/jmeter](https://hub.docker.com/r/justb4/jmeter).

   ```
   ./build.sh
   ```

   The Dockerfile pulls in the Alpine operating system, which is very small (less of an attack surface).

   The last line in the response should be:
   
   <tt>Successfully tagged justb4/jmeter:5.1</tt>


1. Run the test script:

   ```
   ./test.sh
   ```

   The last line in the response should be:

   <pre>
   ==== HTML Test Report ====
   See HTML test report in tests/trivial/report/index.html
   </pre>

1. Switch to your machine's Folder program and navigate to the folder containing files which replaces files cloned in from GitHub:
   
   ```
   cd tests/trivial
   ```
   
   The files are:
   
   * jmeter.log
   * reports folder (see below)
   * test-plan.jmx containing the JMeter test plan.
   * test-plan.jtl containing statistics from the run displayed by the index.html file.
   
   
1. Navigate into the <strong>report</strong> folder and click the <strong>index.html</strong> file to pop up a window displaying the run report. Here is a sample:

![docker-jmeter-report](https://user-images.githubusercontent.com/300046/54093523-1a1c3d80-436f-11e9-8930-750e9b736084.png)



## Image on Docker Hub

Docker image for [Apache JMeter](http://jmeter.apache.org).
This Docker image can be run as the ``jmeter`` command. 
Find Images of this repo on [Docker Hub](https://hub.docker.com/r/justb4/jmeter).

## Building

With the script [build.sh](build.sh) the Docker image can be build
from the [Dockerfile](Dockerfile) but this is not really necessary as
you may use your own ``docker build`` commandline.

### Build Options

Build argumments (see [build.sh](build.sh)) with default values if not passed to build:

- **JMETER_VERSION** - JMeter version, default ``5.1``
- **IMAGE_TIMEZONE** - timezone of Docker image, default ``"Europe/Amsterdam"``

NB **IMAGE_TIMEZONE** setting is not working yet.

## Running

The Docker image will accept the same parameters as ``jmeter`` itself, assuming
you run JMeter non-GUI with ``-n``.

There is a shorthand [run.sh](run.sh) command.
See [test.sh](test.sh) for an example of how to call [run.sh](run.sh).

## User Defined Variables

This is a standard facility of JMeter: settings in a JMX test script
may be defined symbolically and substituted at runtime via the commandline.
These are called JMeter User Defined Variables or UDVs.

See [test.sh](test.sh) and the [trivial test plan](tests/trivial/test-plan.jmx) for an example of UDVs passed to the Docker 
image via [run.sh](run.sh).

See also: http://blog.novatec-gmbh.de/how-to-pass-command-line-properties-to-a-jmeter-testplan/

## Specifics

The Docker image built from the 
[Dockerfile](Dockerfile) inherits from the [Alpine Linux](https://www.alpinelinux.org) distribution:

> "Alpine Linux is built around musl libc and busybox. This makes it smaller 
> and more resource efficient than traditional GNU/Linux distributions. 
> A container requires no more than 8 MB and a minimal installation to disk 
> requires around 130 MB of storage. 
> Not only do you get a fully-fledged Linux environment but a large selection of packages from the repository."

See https://hub.docker.com/_/alpine/ for Alpine Docker images.

The Docker image will install (via Alpine ``apk``) several required packages most specificly
the ``OpenJDK Java JRE``.  JMeter is installed by simply downloading/unpacking a ``.tgz`` archive
from http://mirror.serversupportforum.de/apache/jmeter/binaries within the Docker image.

A generic [entrypoint.sh](entrypoint.sh) is copied into the Docker image and
will be the script that is run when the Docker container is run. The
[entrypoint.sh](entrypoint.sh) simply calls ``jmeter`` passing all argumets provided
to the Docker container, see [run.sh](run.sh) script:

```
sudo docker run --name ${NAME} -i -v ${WORK_DIR}:${WORK_DIR} -w ${WORK_DIR} ${IMAGE} $@
```

## Credits

Thanks to https://github.com/hauptmedia/docker-jmeter
and https://github.com/hhcordero/docker-jmeter-server for providing
the Dockerfiles that inspired me. 
