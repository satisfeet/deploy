# Deploy

Collection of [docker](http://docker.io) files and scripts for deployment of the
satisfeet web stack.

## Usage

**Deploy** comes with a `Makefile` which builds up a complete docker
environment with all satisfeet applications and their dependencies like
databases, backups and proxies.

    $ cd settler && make

However you will need to add your own `dotfiles/netrc` file.
It is required to download component packages from github without hitting the rate limit.

## License

© Bodo Kaiser 2014
