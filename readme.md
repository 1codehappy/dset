# DSet

A set of docker's image for your local and production environments.

I hope this project motivates you for creating your own docker setup and facilitate your life for learning or what else you want.
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
./dset.sh build node
```

* Node

## Worker Image

This image is based on [Official PHP Image](https://hub.docker.com/_/php) using Alpine distro.
You can create with wich version of your choice and edit the configuration in `.env` file:

```bash
./dset.sh build worker
```

* PHP-CLI

## Web Image

This image is based on [Official PHP Image](https://hub.docker.com/_/php) too.
You can create with wich version of your choice and edit the configuration in `.env` file:

```bash
./dset.sh build web
```

* Nginx
* PHP-FPM

## Remove untagged images

This command will remove all untagged docker images.

```bash
./dset.sh clean
```


**Happy coding!!**

---

<sub>by **CodeHappy ;)**</sub>