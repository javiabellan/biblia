# HTTP protocol


## HTTP request

```
GET / HTTP/1.1             -> request line
Host: localhost:8000       \
User-Agent: curl/7.54.0    | Request headers
Accept: */*                /
```

## HTTP response

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Lenght: 11

Hello world
```

```
INTERNET --http--> WEB SERVER --http--> APPLICATION SERVER --wsgi--> WEB FRAMEWORK
                   ==========           ==================           =============
                   apache               gunicorn                     Django
                   ngixn                uWSGI                        Flask
                                                                     FastAPI
```


https://www.youtube.com/watch?v=UklcIDgHtwQ
https://www.youtube.com/watch?v=WqrCnVAkLIo



CGI: Common Gateway Interface (1997)
WSGI: Web Server Gateway Interface (2003)



- caching mechanism:
- Reverse proxy: a system that forwards all requests from the web to our web server and back




- Que pasa si alguien sube una imagen (o imagenens) muy pesada? Relentiza el servidor?
  - gunicorn bloquearia la petición
  - Pero ngixn haria offloading buffering 