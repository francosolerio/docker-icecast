# Icecast-KH in Docker with OpenSSL support

### Run with default password, export port 8000

```bash
docker run -d -p 8000:8000 francosolerio/icecast-kh
$BROWSER localhost:8000
```

### Run with custom password

```bash
docker run -d -p 8000:8000 -e ICECAST_SOURCE_PASSWORD=aaaa -e ICECAST_ADMIN_PASSWORD=bbbb -e ICECAST_PASSWORD=cccc -e ICECAST_RELAY_PASSWORD=dddd francosolerio/icecast-kh
```

### Run with custom configuration

```bash
docker run -d -p 8000:8000 -v /local/path/to/icecast.xml:/etc/icecast.xml francosolerio/icecast-kh
```

### Run with SSL enabled

```bash
docker run -d \
  -p 8000:8000 \
  -p 8001:8001 \
  -v /local/path/to/icecast.xml:/etc/icecast.xml \
  -v /local/path/to/cert.pem:/etc/key.pem \
  -v /local/path/to/key.pem:/etc/cert.pem \
francosolerio/icecast-kh
```

Your icecast.xml file should contain the following lines in the ```<icecast>``` section:
```xml
<listen-socket>
  <port>8001</port>
  <ssl>1</ssl>
</listen-socket>
```

and the following lines in the ```<paths>``` section:
```xml
  <ssl-private-key>/etc/key.pem</ssl-private-key>
  <ssl_certificate>/etc/cert.pem</ssl_certificate>
```


### Docker-compose

```yaml
version: '3.0'
services:
  icecast:
    image: francosolerio/icecast-kh
    volumes:
      - ./logs:/var/log/icecast
      - ./config/icecast.xml:/etc/icecast.xml
      - ./config/ssl/key.pem:/etc/key.pem
      - ./config/ssl/cert.pem:/etc/cert.pem
    environment:
      - ICECAST_SOURCE_PASSWORD=aaaa
      - ICECAST_ADMIN_PASSWORD=bbbb
      - ICECAST_PASSWORD=cccc
      - ICECAST_RELAY_PASSWORD=dddd
      - ICECAST_LOCATION=Earth
      - ICECAST_ADMIN=john@doe.com
      - ICECAST_HOSTNAME=stream@doe.com
    ports:
      - 8000:8000
      - 8001:8001
```

## License

[MIT](https://github.com/francosolerio/docker-icecast-kh/blob/master/LICENSE.md)
