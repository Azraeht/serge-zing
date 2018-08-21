# serge-zing

A Docker-compose for Serge/Zing stack

This docker-compose stack is based on Serge and Zing which is based on pootle project.

Official documentation:
* **Serge** : https://serge.io/
* **Zing** : https://evernote.github.io/zing/

## Getting Started

### Pre-prerequisites

* Got a Git repository for translation
* Got a ssh key (without passphrase) for pull/push this repository (if it's not public)

### Run it

* Create a config/serge.conf
* Create a config/zing.conf
> Got samples in config directory

* Create a .env file
```bash
$ cat .env
MYSQL_ROOT_PASSWORD=my-db-password
```

* Run serge-Zing
```
docker-compose up
```
