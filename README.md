# Composerize

[![Build Status](https://shields.cosanostra-cloud.de/drone/build/alcapone1933/docker-composerize?logo=drone&server=https%3A%2F%2Fdrone.docker-for-life.de)](https://drone.docker-for-life.de/alcapone1933/docker-composerize)
[![Build Status Branch Master](https://shields.cosanostra-cloud.de/drone/build/alcapone1933/docker-composerize/master?logo=drone&label=build%20%5Bbranch%20master%5D&server=https%3A%2F%2Fdrone.docker-for-life.de)](https://drone.docker-for-life.de/alcapone1933/docker-composerize/branches)
[![Docker Pulls](https://shields.cosanostra-cloud.de/docker/pulls/alcapone1933/composerize?logo=docker&logoColor=blue)](https://hub.docker.com/r/alcapone1933/composerize/tags)
![Docker Image Version (latest semver)](https://shields.cosanostra-cloud.de/docker/v/alcapone1933/composerize?sort=semver&logo=docker&logoColor=blue&label=dockerhub%20version)

### FORK

[Composerize](https://github.com/composerize/composerize) , [Decomposerize](https://github.com/composerize/decomposerize) , [Composeverter](https://github.com/outilslibre/composeverter) the original is from github 

#### 3 in 1 [Composerize=Website](https://www.composerize.com/) , [Decomposerize=Website](https://www.decomposerize.com) , [Composeverter=Website](https://www.composeverter.com)

Composerize = http://localhost:80 \
Decomposerize = http://localhost:80/decomposerize \
Composeverter = http://localhost:80/composeverter


#  Docker REPO
https://hub.docker.com/r/alcapone1933/composerize

* * *
### Docker CLI

```bash
docker run -d \
    -p 8080:80 \
    -e TZ=Europe/Berlin \
    --restart always \
    --name composerize \
    alcapone1933/composerize

```

### Docker Compose

```yaml
version: "3.9"
services:
  composerize:
    image: alcapone1933/composerize:latest
    container_name: composerize
    restart: always
    ports:
      - 8080:80
    environment:
      - TZ=Europe/Berlin
```

* * *

## Volume params

| Name    | Value   | Example                    |
|---------|---------|----------------------------|
|  Data   | volume  | composerize_data:/var/www/ |

* * *

## Env params


| Name          | Value     | Example                        |
|---------------|-----------|--------------------------------|
| Timezone      | TZ        | Europe/Berlin                  |


<img src="img/docker-composerize.png"  width="1150" height="650">

<img src="img/docker-decomposerize.png"  width="1150" height="650">

<img src="img/docker-composeverter.png"  width="1150" height="650">
