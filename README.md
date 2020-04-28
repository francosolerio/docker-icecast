# Icecast-KH in Docker

## Run

Run with default password, export port 8000

```bash
docker run -p 8000:8000 francosolerio/icecast-kh
$BROWSER localhost:8000
```

Run with custom password

```bash
docker run -p 8000:8000 -e ICECAST_SOURCE_PASSWORD=aaaa -e ICECAST_ADMIN_PASSWORD=bbbb -e ICECAST_PASSWORD=cccc -e ICECAST_RELAY_PASSWORD=dddd francosolerio/icecast-kh
```

Run with custom configuration

```bash
docker run -p 8000:8000 -v /local/path/to/icecast.xml:/etc/icecast.xml francosolerio/icecast-kh
```

Extends Dockerfile

```Dockerfile
FROM francosolerio/icecast-kh
ADD ./icecast.xml /etc/icecast.xml
```

Docker-compose

```yaml
icecast:
  image: francosolerio/icecast-kh
  volumes:
  - logs:/var/log/icecast2
  - /etc/localtime:/etc/localtime:ro
  environment:
  - ICECAST_SOURCE_PASSWORD=aaa
  - ICECAST_ADMIN_PASSWORD=bbb
  - ICECAST_PASSWORD=ccc
  - ICECAST_RELAY_PASSWORD=ddd
  - ICECAST_LOCATION=Earth
  - ICECAST_ADMIN=john@doe.com
  - ICECAST_HOSTNAME=stream.doe.com
  ports:
  - 8000:8000
```

## License

[MIT](https://github.com/francosolerio/docker-icecast-kh/blob/master/LICENSE.md)
