# Composerize in Docker

### FORK
Docker Composerize the original is from github \
https://github.com/magicmark/composerize OR Here https://github.com/Griefed/docker-App-Collection \
***
**MY REPO**  [Docker HUB](https://hub.docker.com/r/alcapone1933/composerize) https://hub.docker.com/r/alcapone1933/composerize

* * *

* * *

* * *

#######################################################################

### Docker CLI

```bash
docker run -d \
    -p 8080:80 \
    -e TZ=Europe/Berlin \
    -v composerize_data:/var/www/ \  #optional
    --restart always \
    --name composerize \
    alcapone1933/composerize
```

### Docker Compose

```yaml
version: "3.9"
services:
  composerize:
    image: alcapone1933/composerize
    container_name: composerize
    restart: always
    ports:
      - 8080:80
    environment:
      - TZ=Europe/Berlin
    volumes:                        #optional
      - data:/var/www/
volumes:
  data:
```

* * *

* * *

## Volume params


| Name    |Value     |Example                               |
|--------|-----------|--------------------------------------|
| volume | Data      | composerize_data:/var/www/           |

* * *

* * *

## Env params


|Name    |Value      |Example                              |
|--------|-----------|-------------------------------------|
| TZ     | Timezone  | Europe/Berlin                       |

* * *

* * *
