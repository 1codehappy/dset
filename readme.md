# DSet

A set of docker's image for your local and production environments.

I hope this project motivates you for creating your own docker setup and will make better your life for learning or what else you want.
You can `copy`, `edit` or `delete` (if you don't like!!!).

## Installation

Clone this repository from github.

## Commands List

This argument `--help` will show all commands:

```bash
./dset.sh --help
```

## Env file

Create your `.env` file:

```bash
./dset.sh copy-env
```

Now you can edit `.env` and customize what you want.

## Node Image

This image is based on [mhart/alpine-node](https://github.com/mhart/alpine-node).
You can create with wich version of your choice:

```bash
./dset.sh build node \
    --image=foo/bar \                        # Image name, default: dset/node
    --node-version=16.0 \                    # Node Version, default: 14.16
    --path=/var/www/foo \                    # Path to app, default: /var/www/app
    --group=foo \                            # Name of group, default: dset
    --user=bar      \                        # User's name, default: you
    --bash=foor.bar                          # Display on your bash shell, default: dset
```

You will create a docker image with:

* Node
* Yarn

**Warning:** *You can ommit these arguments, the docker image will be created with default values.*

## PHP Image

This image is based on [Official PHP Image](https://hub.docker.com/_/php) too.
You can create with wich version of your choice and edit the configuration in `.env` file:

```bash
./dset.sh build php \
    --image=foo/bar \                       # Image name, default: dset/php
    --php-version=7.4 \                     # PHP Version, default: 8.0
    --php-mode=fpm \                        # PHP cli or fpm, default: fpm
    --path=/var/www/foo \                   # Path to app, default: /var/www/app
    --group=foo \                           # Name of group, default: dset
    --user=bar      \                       # User's name, default: you
    --bash=foor.bar \                       # Display on your bash shell, default: dset
    --xdebug=1 \                            # Activate xdebug, default: 0
    --upload-max-filesize=4M \              # Maximum upload filesize, default: 2M
    --memory-limit=1G \                     # Maximum upload filesize, default: 256M
    --opcache=1 \                           # Activate opcache, default: 0
    --nginx-listen-port=8081 \              # Declare listen port for nginx, default: 8080
    --nginx-vhost-path=/var/www/foo/public  # Declare vhost path for nginx, default: /var/www/app
```

You will create a docker image with:

* Nginx (`--php-mode=fpm`)
* PHP-FPM (`--php-mode=fpm`)
* PHP-CLI (`--php-mode=cli`)

**Warning:** *You can ommit these arguments, the docker image will be created with default values.*

## Remove untagged images

This command will remove all untagged docker images.

```bash
./dset.sh clean
```

Enjoy!!

**Happy coding!!**

---

<sub>by **CodeHappy ;)**</sub>