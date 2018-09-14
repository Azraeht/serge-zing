# serge-zing

> Work in progress

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

* Run Serge-Zing Stack

```bash
$ docker-compose up
Starting l10n.db ... done
Starting l10n.redis ... done
Starting l10n.server ... done
```

* Create super user

```bash
$ docker-compose exec server /bin/bash
root@8ec92977e06e:/# zing createsuperuser --username admin --email se.ci@sewan.fr --noinput
root@8ec92977e06e:/# zing changepassword admin
root@8ec92977e06e:/# zing verify_user admin
```

* Create your project (according to your serge/zing configuration files)
> Admin -> Projects -> **Add Project**

* Init and sync your project

```bash
$ docker-compose exec server /bin/bash
root@8ec92977e06e:/# serge pull --initialize 
/etc/serge-zing/serge.conf
root@2536e11da7bf:/# serge sync /etc/serge-zing/serge.conf
```

### Build local images

* Command `image` and uncomment `build` in docker-compose.yml

```yaml
build: ./serge-zing
#image: azraeht/serge-zing:latest
```
