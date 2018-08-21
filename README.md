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
> Got a sample in config directory
* Run serge-Zing
```
docker-compose up
```

## Run Serge only

```bash
docker run -rm -ti
    -e SERGE_DATA_DIR=/data  # Data directory for serge
    -v /home/bsantus/workspace/serge-zing/config:/etc/serge # provide configuration file
    -v /home/bsantus/.ssh:/tmp/.ssh:ro # give it ssh key for git access
    -v /home/bsantus/temp/data:/data # persistance of data
    azraeht/serge:1.3 /bin/bash
```
