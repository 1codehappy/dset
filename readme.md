# DSet

A set of docker's image for your local and production environments.

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
./dset.sh node
```

* Node

## Worker Image

This image is based on [Official PHP Image](https://hub.docker.com/_/php).
You can create with wich version of your choice and edit the configuration in `.env` file:

```bash
./dset.sh worker
```

* PHP-CLI

## Nginx Image

This image is based on [Official PHP Image](https://hub.docker.com/_/php) too.
You can create with wich version of your choice and edit the configuration in `.env` file:

```bash
./dset.sh nginx
```

* Nginx
* PHP-FPM


Happy coding!!

---

<sub>by **CodeHappy ;)**</sub>